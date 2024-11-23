@tool
extends Node2D


var _angle:float = 0.0
func _process(delta: float) -> void:
	_angle += delta
	%Block.rotation = _angle
	%Block2.rotation = _angle
	%Block3.rotation = _angle
	
