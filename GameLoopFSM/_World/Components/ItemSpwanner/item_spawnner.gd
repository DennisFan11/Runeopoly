extends Node2D

var spawned = false

var time:float = 0.0
func _process(delta: float) -> void:
	time+= delta
	if time >= 2.0 and !spawned:
		for i in range(3):
			for j in range(2):
				ItemFactory.spawn(i, position)
				spawned = true
				
