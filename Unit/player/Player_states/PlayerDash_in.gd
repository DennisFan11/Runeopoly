class_name PlayerDASH_IN # NOTE concrete state
extends PlayerBaseState 
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	_time += delta
	if _time >= body.DASH_IN_TIME:
		return PlayerInDash.new()
	return self # NOTE 狀態未改變

var _time = 0.0
