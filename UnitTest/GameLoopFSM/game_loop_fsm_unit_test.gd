extends Node2D
func _ready():
	Setting.set_all_time(0.3)
	$GameLoopFSM.LOOP_ENTER()
func _input(event):
	if event.is_action_pressed("zoom_in"):
		get_viewport().get_camera_2d().zoom *= 1.1
	elif event.is_action_pressed("zoom_out"):
		get_viewport().get_camera_2d().zoom *= 0.9
	
