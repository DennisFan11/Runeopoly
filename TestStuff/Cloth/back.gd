extends Node2D

func _process(delta):
	queue_redraw()
	
func _draw():
	$"../cloth_sim".rander_back(self)
