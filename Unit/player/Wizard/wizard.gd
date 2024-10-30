extends Player


const SPEED = 13.5 # %
const MAX_SPEED = 200.0
const JUMP_SPEED = -500.0
const G = 2000.0
func _ready():
	$PlayerBaseComponent.set_start_pos(global_position)
	$PlayerBaseComponent.set_player(self)
	

func _physics_process(delta):
	#var vec = Input.get_vector("left", "right", "up", "down")
	
	if not is_on_floor():
		velocity.y += G * delta
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_SPEED
	var direction = Input.get_axis("left", "right")
	velocity.x = lerpf(velocity.x, direction * MAX_SPEED, delta * SPEED)

	move_and_slide()
