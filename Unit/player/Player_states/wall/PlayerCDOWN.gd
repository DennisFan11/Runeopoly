class_name PlayerCDOWN
extends PlayerClimbState
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	pass
	return self # NOTE 狀態未改變
