class_name FlyEnemy extends Enemy


var _attack_area:Area2D
func set_attack_area( area:Area2D )-> void: # 由子類調用
	_attack_area = area

var _nav_agent:NavigationAgent2D
func set_nav_agent( agent:NavigationAgent2D )->void: # 由子類調用
	_nav_agent = agent


#var _time:float = 1.0
#func get_next_path_position(delta:float):
	#_time += delta
	#if _time >= 1.0:
		#_time = 0.0
		#_nav_agent.target_position = _get_player_pos()
	#return _nav_agent.get_next_path_position()

func get_path_vec()->Vector2:
	return PathfindingServer.SampVector(global_position)

var path_agent:Control
func _ready() -> void:
	path_agent = PathfindingServer.AddEnemy()

var DMG:float = 10.0
var ATTACK_GUARD:float = 0.5
func _physics_process(delta):
	path_agent.position = global_position
	
	const SPEED = 4.5 # 單位為百分比
	const MAX_SPEED = 50.0 * 2.0
	#var target = get_next_path_position(delta)
	var vec = (get_path_vec()).normalized() * MAX_SPEED
	velocity = velocity.lerp(vec, SPEED * delta)
	if FORCE.length()>=1.0:
		velocity = FORCE
		FORCE *= 0.7
	move_and_slide()
	
	for i in $AttackArea.get_overlapping_bodies(): # 攻擊
		if (i is Unit) and i.get_team() != get_team():
			i.hurt(DMG, ATTACK_GUARD)

func _death(): # NOTE 死亡時自動呼叫 生命週期
	path_agent.queue_free()
	super()
func _exit_tree() -> void:
	if is_instance_valid(path_agent):
		path_agent.queue_free()
