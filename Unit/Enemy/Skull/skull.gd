extends Enemy


const SPEED = 4.5 # 單位為百分比
const MAX_SPEED = 20.0
var dmg:float = 10.0
var attack_guard:float = 0.5

func _physics_process(delta):
	var vec = (_get_player_pos()-position).normalized() * MAX_SPEED
	velocity = velocity.lerp(vec, SPEED * delta)
	move_and_slide()
	
	for i in $AttackArea.get_overlapping_bodies(): # 攻擊
		if (i is Unit) and i.get_team() != get_team():
			i.hurt(dmg, attack_guard)
			
