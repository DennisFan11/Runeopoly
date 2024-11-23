@tool
extends Sprite2D

var time:float = 0.0

func _process(delta: float) -> void:
	time += delta*5
	#rotation = time
	scale.x = sin(time)
