extends Node2D
func _process(delta):
	queue_redraw()
func _draw():
	$"../..".rander_front(self)
