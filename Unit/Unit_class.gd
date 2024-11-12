@icon("res://Unit/Unit.png")
class_name Unit
extends CharacterBody2D
enum {UNIT, PLAYER, ENEMY}
#region 對外接口
func get_team()-> int: # 由子類完成 給外部的接口
	return UNIT
func hurt(value: float, guard_time:float=0.0): # 給外部的接口 # guard 為霸體時間
	if !_is_guard():
		NumberEffect.Spawn(position, "[color=red]-"+str(value)+"[/color]")
		_hp -= value
		_guard_time += guard_time
		#print("left:", _hp)
var FORCE = Vector2.ZERO
func push(force:Vector2): # 擊退
	if !_is_guard():
		FORCE +=force
#endregion
func _death(): # NOTE 死亡時自動呼叫 生命週期
	pass



var _hp: float = 100.0:  # 生命值
	set(new):
		_hp = new
		if _hp<=0:
			_death()
			queue_free()
var _guard_time:float = 0.0: #剩餘霸體時間
	set(new):
		_guard_time = new
		if _guard_time<0.0:
			_guard_time = 0.0

func _is_guard()-> bool: # 是否處於霸體
	return _guard_time>0.1


func _process(delta):
	_guard_time -= delta
