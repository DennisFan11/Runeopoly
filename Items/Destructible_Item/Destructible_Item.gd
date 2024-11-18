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


func _gravity_move(delta: float)-> void:
	pass
func _hook_move(delta: float)-> void:
	body.apply_impulse(_get_force() * delta)







#
