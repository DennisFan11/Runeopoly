extends Node2D

const CLOTH_Y = 10 # 布料在垂直方向上的点数量
const CLOTH_X = 30 # 布料在水平方向上的点数量 20

var flip:bool = false:
	set(new):
		flip = new
		if new:
			scale.x = -1
			$Node/cloth_sim.inverse = true
		else:
			scale.x = 1
			$Node/cloth_sim.inverse = false

@onready var cloth := $Node/cloth_sim
func _ready():
	cloth.CLOTH_Y = CLOTH_Y
	cloth.CLOTH_X = CLOTH_X
	cloth.init()
func _process(delta):
	var points = $Path2D.get_point_arr(CLOTH_X)
	$Node/cloth_sim.set_pin(points)

func set_floor(new:float)->void: # 設置地板
	cloth.set_floor(new)
func cut(point:Vector2, r:float): # 裁切
	cloth.cut(point, r)
func set_player(canvas):
	$Node/cloth_sim.inside = canvas
