class_name Weapon extends CanSpawn
enum {UNIT, PLAYER, ENEMY}
var __last_dir:Vector2 = Vector2.ONE
func _attacking_dir()-> Vector2: #　獲取攻擊方向
	var dir:Vector2 = Input.get_vector("s_left", "s_right", "s_up", "s_down")
	if dir.length()!=0:
		return dir
	var enemy = InstanceGetter.get_player().find_enemy(global_position)
	if enemy:
		return (enemy.global_position- global_position).normalized()
	var mdir := Input.get_vector("left", "right", "up", "down")
	if mdir.length()!=0:
		__last_dir = mdir
		return mdir
	return __last_dir

func _is_attacking()-> bool: 
	var dir:Vector2 = Input.get_vector("s_left", "s_right", "s_up", "s_down")
	if dir.length()!=0:
		return true
	if Input.is_action_pressed("fire"):
		return true
	return false


enum CombatState{IDLE, DEFFEND, ATTACK}
var _combat_state: int = CombatState.IDLE

func _combat_handle(old:int):
	match old:
		CombatState.IDLE:
			if _is_attacking():
				return CombatState.ATTACK
			return old
		CombatState.DEFFEND:
			pass
		CombatState.ATTACK:
			_fire(_attacking_dir())
			if !_is_attacking():
				return CombatState.IDLE
	return old



func _physics_process(delta):
	_combat_state = _combat_handle(_combat_state)



func _fire(dir:Vector2): # 由子類複寫
	pass




#
