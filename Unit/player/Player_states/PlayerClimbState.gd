class_name PlayerClimbState # abstract State
extends PlayerBaseState
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	if dir.y!=0.0:
		body.velocity.y = lerpf(body.velocity.y, dir.y * body.WALL_MAX_SPEED, delta * body.WALL_ACCELERATION)
	else:
		body.velocity.y = lerpf(body.velocity.y, dir.y * body.WALL_MAX_SPEED, delta * body.WALL_DECELERATION)
	# 牆壁吸附
	if body.last_flip:
		body.velocity.x = -0.1 * body.MAX_SPEED
	else:
		body.velocity.x = 0.1 * body.MAX_SPEED
	
	if not (body.is_grab() and Input.is_action_pressed("grab")):
		return PlayerIDLE.new()
	if Input.is_action_just_pressed("jump"):
		body.velocity.y += body.JUMP_SPEED
		if dir.x!=0.0:
			body.velocity.x = dir.x * 0.5 * body.MAX_SPEED
		return PlayerJUMP.new()
	
	if dir.y !=0.0:
		if dir.y >=0.0:
			return PlayerCDOWN.new()
		elif dir.y < 0.0:
			return PlayerCUP.new()
	return PlayerCIDLE.new()
	
	return self # NOTE 狀態未改變
