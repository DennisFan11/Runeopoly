class_name Item extends Node
var ID:int = -1


static var player_pos:Vector2
var EndTarget:Vector2 # 到達後消除


func set_pos(pos:Vector2):
	pass
func get_pos()-> Vector2:
	return Vector2.ZERO

func _IDLE(delta: float)-> void:
	_rope.visible = false
func _CONNECTED_IDLE(delta: float)-> void:
	_rope.visible = true
	_update_rope()
func _SELECT(delta: float)-> void:
	_rope.visible = true
	_update_rope()
func _USED(delta: float):
	if (get_pos()-EndTarget).length()<= 5.0:
		queue_free()

var _rope:Line2D
func _update_rope():
	_rope.points = [player_pos, get_pos()]
func _ready() -> void:
	var scene:PackedScene = preload("res://Items/Rope/Rope.tscn")
	_rope = scene.instantiate()
	add_child(_rope)
	



var _state:int = IDLE
enum {IDLE, CONNECTED_IDLE, SELECT, CHARGING, USED}

func set_state(new:int):
	_state = new
	if new == USED:
		_rope.queue_free()
func _physics_process(delta: float) -> void:
	match _state:
		IDLE:
			_IDLE(delta)
		CONNECTED_IDLE:
			_CONNECTED_IDLE(delta)
		SELECT:
			_SELECT(delta)
		USED:
			_USED(delta)




func _get_force()-> Vector2: # 計算connect加速度
	const ROPE_DIST:float = 40.0
	const K:float = 20.0
	var dist:Vector2 = get_pos() - player_pos
	
	if dist.length() <= ROPE_DIST: # 繩子長度內
		return Vector2.ZERO
	dist -= dist.normalized()*ROPE_DIST
	var force:Vector2 = -K * dist
	return force












#
