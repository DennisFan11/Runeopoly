class_name PlayerDASH_OUT # NOTE concrete state
extends PlayerBaseState 
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	_timer += delta
	if _timer >= body.DASH_OUT_TIME:
		if body.is_on_floor():
			return PlayerIDLE.new()
		else:
			return PlayerJUMP.new()
	return self # NOTE 狀態未改變	
var _timer:float = 0.0
