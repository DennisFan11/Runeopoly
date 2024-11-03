class_name PlayerFALL
extends PlayerInAir
func UPDATE(delta:float, body:Player, dir:Vector2)->PlayerBaseState:
	var next = super(delta, body, dir) # 父類別優先調用
	if next != self: return next # 狀態改變
	# 執行
	if Input.is_action_just_pressed("jump") and body.coyote_timer>=0.0:
		body.velocity.y = body.JUMP_SPEED
		return PlayerJUMP.new()
	if body.velocity.y < 0.0:
		return PlayerJUMP.new()
	if body.is_grab() and Input.is_action_pressed("grab"):
		body.last_flip = body.flip
		return PlayerCIDLE.new()
	
		
	return self # NOTE 狀態未改變
