@tool
extends Sprite2D

var time:float = 0.0

func _process(delta: float) -> void:
	time += delta*10
	scale.x = sin(time)/4.0
