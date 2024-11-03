class_name PlayerInAir
extends PlayerNormalState
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	body.velocity.y += body.G * delta # 施加重力
	if Input.is_action_just_pressed("jump"):
		body.fall_jump_timer = body.FALL_JUMP_TIME
	if body.is_on_floor():
		return PlayerIDLE.new()
	return self # NOTE 狀態未改變
	
