class_name ToxicArea extends Bullet


func _get_damage()-> float:
	return 50.0
func _get_force()-> float:
	return 0.0
func _handle(old:int, delta:float): 
	pass

func _get_guard()-> float:
	return 1.0

static var LEVEL:float = 0
var _time = 0.0
func _process(delta: float) -> void:
	_time += delta
	if _time >= LEVEL:
		queue_free()
		return
	for i in $Area2D.get_overlapping_bodies():
		_check_hit(i)
