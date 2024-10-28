extends Node2D

# Globals

const ACCURACY = 5 # 模拟精度，决定布料每帧更新的次数
const GRAVITY = Vector2(0, 10) * 4.0 # 重力向量，决定布料的重力作用
var CLOTH_Y = 34 # 布料在垂直方向上的点数量
var CLOTH_X = 44 # 布料在水平方向上的点数量
const SPACING = 4 # 点之间的间距，用于定义布料的网格大小 8
const TEAR_DIST = 6000 # 允许的最大距离，用于判断布料是否撕裂 60
const FRICTION = 0.99 # 摩擦系数，影响布料点的运动阻力 0.99
const BOUNCE = 0.8 # 弹性系数，决定布料点与边界的反弹效果 0.5
const WIDTH = 800 # 画布的宽度
var HEIGHT = 162 # 画布的高度

#const BG_COLOR = Color.ALICE_BLUE # 背景颜色，设置画布的背景色

var mouse = {
	"cut": 8,
	"influence": 36,
	"down": false,
	"button": MOUSE_BUTTON_LEFT,
	"x": 0,
	"y": 0,
	"px": 0,
	"py": 0
}

var points = []
var squares = []
var inited:bool = false
var inverse:bool = false
var inside:CanvasItem
func set_pin(new_pin:PackedVector2Array ): # 每偵重固定點
	for x in CLOTH_X +1:
		points[x].pin(new_pin[x])

func cut(point:Vector2, r:float): # 裁切
	for i:PointInfo in points:
		if (i.position - point).length() <= r:
			i.free_all_constraint()

func set_floor(new:float): # 設置地板
	for i:PointInfo in points:
		i.set_height(new)

func init():
	inited = true
	var start_x = WIDTH / 2 - CLOTH_X * SPACING / 2
	for y in CLOTH_Y + 1:
		for x in CLOTH_X + 1:
			var point = PointInfo.new(Vector2(start_x + x * SPACING, 20 + y * SPACING), mouse)
			
			if y == 0:
				point.pin(point.position)

			if x > 0:
				point.attach(points.back())

			if y > 0:
				point.attach(points[x + (y - 1) * (CLOTH_X + 1)])

			points.append(point)
	for x in CLOTH_X:
		for y in CLOTH_Y: # square初始化
			var p1 = points[x + y*(CLOTH_X + 1)]
			var p2 = points[x+1 + y*(CLOTH_X + 1)]
			var p3 = points[x+1 + (y+1)*(CLOTH_X + 1)]
			var p4 = points[x + (y+1)*(CLOTH_X + 1)]
			
			var square:Square = Square.new(p1, p2, p3, p4)
			squares.append(square)
			p1.add_square(square)
			p2.add_square(square)
			p3.add_square(square)
			p4.add_square(square)
	for i:PointInfo in points:
		for c:Constraint in i.constraints:
			c.find_square()
	set_process(true)
	set_floor(HEIGHT)

func _process(delta):
	if inited:
		update_cloth(delta)
		#queue_redraw()

#func _draw():
	## Draw all constraints
	##draw_rect(Rect2(Vector2.ZERO, Vector2(WIDTH, HEIGHT)), BG_COLOR)
	#if inited:
		#var inside_drawed = false
		#for i in squares:
			#if is_instance_valid(i): # FIXME
				#if i.draw(self, inverse) and !inside_drawed:
					#inside_drawed = true
					#inside.queue_redraw()
		#for point in points:
			#point.draw(self)

func rander_back(canvas:CanvasItem): # 先調用
	for i in range(squares.size()):
		if is_instance_valid(squares[i]): # FIXME
			squares[i].draw(canvas, inverse)
			if i >= squares.size()/2.0:
				_last_draw_index = i
				break
	print("rander_back to ", _last_draw_index)
	
var _last_draw_index:int = 0
func rander_front(canvas:CanvasItem): #後調用
	
	for i in range(_last_draw_index, squares.size()):
		if is_instance_valid(squares[i]): # FIXME
			squares[i].draw(canvas, inverse)
			for p:PointInfo in squares[i].points:
				p.draw(canvas)
	
	#for point in points:
		#point.draw(canvas)
	print("rander_front to ", squares.size())




func update_cloth(delta):
	for i in range(ACCURACY):
		for point in points:
			point.resolve()

	for point in points:
		point.update(delta)




class Square: # NOTE Constraint中儲存著相鄰Square的引用, Constraint釋放時自動釋放
	var points:Array[PointInfo]
	func _init(p1, p2, p3, p4):
		points = [p1, p2, p3, p4]
	func draw(canvas:CanvasItem, inverse:bool):
		var polygon = [points[0].position,points[1].position,points[2].position,points[3].position]
		if Geometry2D.is_polygon_clockwise(polygon) != inverse:
			polygon = Geometry2D.convex_hull(polygon)
			if Geometry2D.triangulate_polygon(polygon).size() == 0:
				return false
			canvas.draw_colored_polygon(polygon, Color.AQUAMARINE)
			return false
		else:
			polygon = Geometry2D.convex_hull(polygon)
			if Geometry2D.triangulate_polygon(polygon).size() == 0:
				return true
			canvas.draw_colored_polygon(polygon, Color.AQUA)
			return true
		
		#canvas.draw_polygon(points, [Color.AQUAMARINE,Color.AQUAMARINE,Color.AQUAMARINE,Color.AQUAMARINE])

class PointInfo:
	var position : Vector2
	var prev_position : Vector2
	var velocity : Vector2 = Vector2.ZERO
	var pin_position : Vector2 = Vector2.ZERO
	var constraints:Array[Constraint] = []
	var mouse = {}
	var squares:Array[Square] = []
	
	var HEIGHT:float = 600 # 地板座標
	func set_height(new:float):
		HEIGHT = new
	func _init(pos, my_mouse):
		position = pos
		mouse = my_mouse
		prev_position = pos
	func add_square(s:Square):
		squares.append(s)
	func update(delta):
		if pin_position != Vector2.ZERO:
			return

		#if mouse["down"]:
			#var mouse_pos = Vector2(mouse["x"], mouse["y"])
			#var dist = position.distance_to(mouse_pos)
#
			#if mouse["button"] == MOUSE_BUTTON_LEFT and dist < mouse["influence"]:
				#prev_position = position - (mouse_pos - Vector2(mouse["px"], mouse["py"]))
			#elif dist < mouse["cut"]:
				#constraints.clear()

		apply_force(GRAVITY)

		var new_pos = position + (position - prev_position) * FRICTION + velocity * delta
		prev_position = position
		position = new_pos
		velocity = Vector2.ZERO

		#if position.x >= WIDTH:
			#prev_position.x = WIDTH + (WIDTH - prev_position.x) * BOUNCE
			#position.x = WIDTH
		#elif position.x <= 0:
			#prev_position.x *= -BOUNCE
			#position.x = 0
#
		if position.y >= HEIGHT:  # NOTE 可用作地板檢測
			prev_position.y = HEIGHT + (HEIGHT - prev_position.y) * BOUNCE
			position.y = HEIGHT
		#elif position.y <= 0:
			#prev_position.y *= -BOUNCE
			#position.y = 0

	func draw(canvas):
		for constraint in constraints:
			constraint.draw(canvas)

	func resolve():
		if pin_position != Vector2.ZERO:
			position = pin_position
			return

		for constraint in constraints:
			constraint.resolve()

	func attach(point):
		constraints.append(Constraint.new(self, point))

	func free2(constraint):
		constraint.free_square() # 擦除square
		constraints.erase(constraint)
	func free_all_constraint():
		for i:Constraint in constraints:
			i.free_square() # 擦除square
		constraints.clear()

	func apply_force(force):
		velocity += force

	func pin(pin_position):
		self.pin_position = pin_position


class Constraint:
	var p1 : PointInfo
	var p2 : PointInfo
	var length : float
	var squares:Array[Square]

	func _init(p1, p2):
		self.p1 = p1
		self.p2 = p2
		length = SPACING
	
	func free_square(): # 擦除前必須調用
		for i:Square in squares:
			if is_instance_valid(i):
				i.free()

	func find_square(): # square更新完調用
		for i:Square in p1.squares:
			if (i in p2.squares):
				squares.append(i)
	
	func resolve():
		var delta = p1.position - p2.position
		var dist = delta.length()

		if dist < length:
			return

		var diff = (length - dist) / dist

		if dist > TEAR_DIST:
			p1.free2(self)

		var offset = delta * (diff * 0.5 * (1 - length / dist))

		p1.position += offset
		p2.position -= offset

	func draw(canvas):
		canvas.draw_line(p1.position, p2.position, Color.BLACK)
