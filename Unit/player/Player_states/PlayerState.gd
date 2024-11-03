class_name PlayerBaseState # abstract State
extends RefCounted

func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	
	if (dir.x < 0.0):
		body.flip = true
	elif (dir.x > 0.0):
		body.flip = false
	if Input.is_action_just_pressed("dash"):
		return PlayerInDash.new()
	#---狀態不變
	return self
	##---切換狀態
	#return PlayerBaseState.new()
