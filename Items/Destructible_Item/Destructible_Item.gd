class_name Destructible_Item extends Item


@export var body:RigidBody2D
func set_pos(pos:Vector2):
	body.position = pos
func get_pos()-> Vector2:
	return body.position

func _IDLE(delta: float)-> void:
	_gravity_move(delta)
	super(delta)
	
func _CONNECTED_IDLE(delta: float)-> void:
	_gravity_move(delta)
	_hook_move(delta)
	super(delta)
func _SELECT(delta: float)-> void:
	_gravity_move(delta)
	_hook_move(delta)
	super(delta)
func _USED(delta: float):
	body.apply_impulse(_get_end_force() * delta)
	super(delta)

func _gravity_move(delta: float)-> void:
	pass
func _hook_move(delta: float)-> void:
	body.apply_impulse(_get_force() * delta)



func _get_end_force()-> Vector2: # 計算End加速度
	const K:float = 100.0
	var dist:Vector2 = get_pos() - EndTarget
	var force:Vector2 = -K * dist
	return force



#
