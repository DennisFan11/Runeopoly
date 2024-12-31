class_name LightningChain extends Bullet

var touched:Array[Enemy]
func _get_damage()-> float:
	return 10.0
func _get_force()-> float:
	return 0.0
func _handle(old:int, delta:float): 
	pass

func _get_guard()-> float:
	return 0.1

static var LEVEL:float = 0.5
var _time = 0.0
func _process(delta: float) -> void:
	_time += delta
	if _time >= LEVEL:
		queue_free()
		return
	for i in $Area2D.get_overlapping_bodies():
		if i is Unit and !(i in touched):
			if (i as Unit).get_team() != _team:
				_check_hit(i)
				touched.append(i)
				var node = preload("res://Unit/Weapon/bullets/LightningChain/Line/Line.tscn").instantiate()
				node.points = [position, i.position]
				InstanceGetter.get_world().add_child(node)
				position = i.position
				break
			
