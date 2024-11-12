class_name World
extends Node2D

signal exit
func EXIT(): # 由子類呼叫
	_EXIT()
	exit.emit()
	queue_free()
func ENTER(): # 給外部呼叫
	InstanceGetter.set_world(self)
	_load_player()
	get_tree().create_timer(Setting.get_explore_time()).timeout.connect(EXIT)
	

func _EXIT(): # 在子類複寫 並呼叫 EXIT
	pass
func _ENTER(): # 在子類複寫
	pass

func _load_player():
	var instance:Player = Setting.get_game_info().get_player_instance()
	instance.position = _get_EntryPoint().position
	add_child(instance)


func _get_EntryPoint()-> Node2D:
	for i in get_children():
		if i.is_in_group("EntryPoint"):
			return i
	assert(false, "from World: can't get EntryPoint")
	return null

func _get_EnemySpawnPoints()-> Array[Node2D]:
	var arr:Array[Node2D] = []
	for i in get_children():
		if i.is_in_group("EnemySpawnPoint"):
			arr.append(i)
	assert(arr.size() != 0, "from World: can't get any EnemySpawnPoint")
	return arr
	
