extends Node2D
func _ready():
	Setting.set_all_time(0.3)
	$GameLoopFSM.LOOP_ENTER()

	
