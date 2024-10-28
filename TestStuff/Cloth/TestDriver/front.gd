extends Node2D
func _draw():
	$"../../Cloth".rander_front(self)
func _process(delta):
	queue_redraw()
