class_name PlayerNormalState # abstract State
extends PlayerBaseState
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	if dir.x!=0.0:
		body.velocity.x = lerpf(body.velocity.x, dir.x * body.MAX_SPEED, delta * body.ACCELERATION)
	else:
		body.velocity.x = lerpf(body.velocity.x, dir.x * body.MAX_SPEED, delta * body.DECELERATION)
	body.last_flip = body.flip
	return self # NOTE 狀態未改變
# NOTE 負責左右移動

#class OtherState extends BaseState:
	#pass
#
#class BaseState:
	#func Update(delta: float)-> BaseState:
		#return OtherState.new() # 狀態改變 回傳新的狀態實例
#
#class PlayerMoveState extends BaseState:
	#func Update(delta: float)-> BaseState:
		## do something
		#return super(delta) # 狀態未改變, 呼叫父類別的同名方法
#
#var _state:BaseState
#func _process(delta: float):
	#_state = _state.Update(delta)
