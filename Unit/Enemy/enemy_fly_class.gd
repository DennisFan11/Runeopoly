class_name FlyEnemy extends Enemy


var _attack_area:Area2D
func set_attack_area( area:Area2D )-> void: # 由子類調用
	_attack_area = area

var _nav_agent:NavigationAgent2D
func set_nav_agent( agent:NavigationAgent2D )->void: # 由子類調用
	_nav_agent = agent


var _time:float = 1.0
func get_next_path_position(delta:float):
	_time += delta
	if _time >= 1.0:
		_time = 0.0
		_nav_agent.target_position = _get_player_pos()
	return _nav_agent.get_next_path_position()

var DMG:float = 10.0
var ATTACK_GUARD:float = 0.5
func _physics_process(delta):
	const SPEED = 4.5 # 單位為百分比
	const MAX_SPEED = 50.0 * 2.0
	var target = get_next_path_position(delta)
	var vec = (target-position).normalized() * MAX_SPEED
	velocity = velocity.lerp(vec, SPEED * delta)
	if FORCE.length()>=1.0:
		velocity = FORCE
		FORCE *= 0.7
	move_and_slide()
	
	for i in $AttackArea.get_overlapping_bodies(): # 攻擊
		if (i is Unit) and i.get_team() != get_team():
			i.hurt(DMG, ATTACK_GUARD)

func _death(): # NOTE 死亡時自動呼叫 生命週期
	super()
