extends Node2D

# Globals
const ACCURACY = 5
const GRAVITY = Vector2(0, 10)
const CLOTH_Y = 34
const CLOTH_X = 44
const SPACING = 8
const TEAR_DIST = 60
const FRICTION = 0.99
const BOUNCE = 0.5
const WIDTH = 800
const HEIGHT = 600
const BG_COLOR = Color.ALICE_BLUE


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

func _ready():

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

	set_process(true)

func _process(delta):
	update_cloth(delta)
	queue_redraw()

func _draw():
	# Draw all constraints
	draw_rect(Rect2(Vector2.ZERO, Vector2(WIDTH, HEIGHT)), BG_COLOR)
	for point in points:
		point.draw(self)

func update_cloth(delta):
	for i in range(ACCURACY):
		for point in points:
			point.resolve()

	for point in points:
		point.update(delta)

func _input(event):
	if event is InputEventMouseMotion:
		mouse["px"] = mouse["x"]
		mouse["py"] = mouse["y"]
		mouse["x"] = event.position.x
		mouse["y"] = event.position.y
	elif event is InputEventMouseButton:
		mouse["down"] = event.pressed
		mouse["button"] = event.button_index
		mouse["px"] = mouse["x"]
		mouse["py"] = mouse["y"]
		mouse["x"] = event.position.x
		mouse["y"] = event.position.y


class PointInfo:
	var position : Vector2
	var prev_position : Vector2
	var velocity : Vector2 = Vector2.ZERO
	var pin_position : Vector2 = Vector2.ZERO
	var constraints = []
	var mouse = {}

	func _init(pos, my_mouse):
		position = pos
		mouse = my_mouse
		prev_position = pos

	func update(delta):
		if pin_position != Vector2.ZERO:
			return

		if mouse["down"]:
			var mouse_pos = Vector2(mouse["x"], mouse["y"])
			var dist = position.distance_to(mouse_pos)

			if mouse["button"] == MOUSE_BUTTON_LEFT and dist < mouse["influence"]:
				prev_position = position - (mouse_pos - Vector2(mouse["px"], mouse["py"]))
			elif dist < mouse["cut"]:
				constraints.clear()

		apply_force(GRAVITY)

		var new_pos = position + (position - prev_position) * FRICTION + velocity * delta
		prev_position = position
		position = new_pos
		velocity = Vector2.ZERO

		if position.x >= WIDTH:
			prev_position.x = WIDTH + (WIDTH - prev_position.x) * BOUNCE
			position.x = WIDTH
		elif position.x <= 0:
			prev_position.x *= -BOUNCE
			position.x = 0

		if position.y >= HEIGHT:
			prev_position.y = HEIGHT + (HEIGHT - prev_position.y) * BOUNCE
			position.y = HEIGHT
		elif position.y <= 0:
			prev_position.y *= -BOUNCE
			position.y = 0

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
		constraints.erase(constraint)

	func apply_force(force):
		velocity += force

	func pin(pin_position):
		self.pin_position = pin_position


class Constraint:
	var p1 : PointInfo
	var p2 : PointInfo
	var length : float

	func _init(p1, p2):
		self.p1 = p1
		self.p2 = p2
		length = SPACING

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
