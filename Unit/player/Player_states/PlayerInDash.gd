class_name PlayerInDash # NOTE concrete state
extends PlayerBaseState 
var _dash_timer:float = 0.0
var _dash_speed:Vector2 = Vector2.ZERO
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	if !_first:
		_first = true
		ENTER(body, dir)
	
	_dash_timer -= delta
	body.velocity = _dash_speed
	if _dash_timer <=0.0:
		return PlayerDASH_OUT.new()
	return self # NOTE 狀態未改變
var _first:bool = false
func ENTER(body:Player, dir:Vector2):
	_dash_timer = body.DASH_TIME
	_dash_speed = dir * body.DASH_SPEED
	
