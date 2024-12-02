class_name World
extends Node2D
const EXPLORE_TIME:float = 300.0

signal exit
func EXIT(): # 由子類呼叫
	_EXIT()
	exit.emit()
	queue_free()
func ENTER(): # 給外部呼叫
	InstanceGetter.set_world(self)
	_load_player()
	get_tree().create_timer(EXPLORE_TIME).timeout.connect(EXIT)
	var scene := preload("res://GameLoopFSM/_World/BattleUI/BattleUI.tscn")
	var node := scene.instantiate()
	add_child(node)
	node.BattleExit.connect(EXIT)
	

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





#region Enemy Spawnner

var time = 0.0
func _process(delta):
	time += delta
	if time >0.5:
		time = 0.0
		_spawn()
		
var enemy_instance = preload("res://Unit/Enemy/Skull/Skull.tscn")
func _spawn():
	var pos = _get_EnemySpawnPoints().pick_random().position
	var node = enemy_instance.instantiate()
	node.position = pos
	add_child(node)
#endregion
