extends Node2D
func _draw():
	$"../../Cloth".rander_back(self)
func _process(delta):
	queue_redraw()
