extends Player



func _ready():
	super()
	$PlayerBaseComponent.set_start_pos(global_position)
	$PlayerBaseComponent.set_player(self)
	
	
func _process(delta):
	super(delta)
	$Cloak.inverse = last_flip
	var state = _check_state(_state)
	$State.text = _map[state] 
	%AnimatedSprite2D.play(_map[state])
	%AnimatedSprite2D.flip_h = last_flip
	PathfindingServer.SetTarget(global_position)
	
func _physics_process(delta):
	super(delta)
func _input(event):
	if event.is_action_pressed("fire"):
		$Cloak.set_force((global_position - get_global_mouse_position()).normalized()* 99.0)


func is_grab():
	return _is_grab($Area2DLeft, $Area2DRight)



enum {IDLE, MOVE, JUMP, FALL, C_IDLE, C_UP, C_DOWN, DASH_IN, DASH, DASH_OUT}
var _map = ["IDLE", "MOVE", "JUMP", "FALL", "C_IDLE", "C_UP", "C_DOWN", "DASH_IN", "DASH_LOOP", "DASH_OUT"]
func _check_state(state:PlayerBaseState):
	if state is PlayerIDLE:
		return IDLE
	if state is PlayerMOVE:
		return MOVE
	if state is PlayerJUMP:
		return JUMP
	if state is PlayerFALL:
		return FALL
	if state is PlayerCIDLE:
		return C_IDLE
	if state is PlayerCUP:
		return C_UP
	if state is PlayerCDOWN:
		return C_DOWN
	if state is PlayerInDash:
		return DASH
	if state is PlayerDASH_IN:
		return DASH_IN
	if state is PlayerDASH_OUT:
		return DASH_OUT







#
