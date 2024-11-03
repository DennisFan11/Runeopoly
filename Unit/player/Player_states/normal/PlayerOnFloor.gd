class_name PlayerOnFloor
extends PlayerNormalState
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	if Input.is_action_just_pressed("jump") or body.fall_jump_timer > 0.0:
		body.velocity.y += body.JUMP_SPEED
		return PlayerJUMP.new()
	if !body.is_on_floor():
		body.coyote_timer = body.COYOTE_TIME # 重置土狼時間
		return PlayerFALL.new()
	return self # NOTE 狀態未改變
