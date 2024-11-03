class_name PlayerMOVE
extends PlayerOnFloor
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	if dir.x == 0.0:
		return PlayerIDLE.new()
	return self # NOTE 狀態未改變
