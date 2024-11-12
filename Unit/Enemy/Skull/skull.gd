extends Enemy


const SPEED = 4.5 # 單位為百分比
const MAX_SPEED = 50.0 * 2.0
var dmg:float = 10.0
var attack_guard:float = 0.5

func _physics_process(delta):
	var target = $NavigationAgent2D.get_next_path_position()
	var vec = (target-position).normalized() * MAX_SPEED
	velocity = velocity.lerp(vec, SPEED * delta)
	if FORCE.length()>=1.0:
		velocity = FORCE
		FORCE *= 0.7
	move_and_slide()
	
	_update(delta)
	
	for i in $AttackArea.get_overlapping_bodies(): # 攻擊
		if (i is Unit) and i.get_team() != get_team():
			i.hurt(dmg, attack_guard)
	
var _time:float = 30.0 
func _update(delta:float):
	_time+= delta
	if _time>=1.0:
		_time = 0.0
		$NavigationAgent2D.target_position = _get_player_pos()
