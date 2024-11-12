class_name Bullet extends CanSpawn
enum {UNIT, PLAYER, ENEMY}
var _team:int = PLAYER
var _dir:Vector2

func Spawn(pos:Vector2, dir:Vector2, team:int=PLAYER)-> void:
	_team = team
	position = pos
	_dir = dir

enum {FLY, HIT}
var _state: int = FLY
func _physics_process(delta):
	_handle(_state, delta)



#region 由子類完成
func _get_damage()-> float:
	return 0.0
func _get_force()-> float:
	return 0.0
func _handle(old:int, delta:float): 
	pass
#endregion






func _check_hit(body:Node2D)-> bool: # 檢測是否擊中目標的工具函數
	if body is Unit:
		if (body as Unit).get_team() != _team:
			body.push(_dir*_get_force())
			body.hurt(_get_damage())
			return true
	if body.is_in_group("Wall"):
		return true
	return false
