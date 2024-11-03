class_name PlayerJUMP
extends PlayerInAir
var jumped:bool = false
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	if body.velocity.y > 0.0:
		return PlayerFALL.new()
	return self # NOTE 狀態未改變
