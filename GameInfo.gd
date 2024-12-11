class_name GameInfo # NOTE 由GameLoopFSM 創建 並將ref存入Setting
extends Resource
var _player_file:PackedScene = preload("res://Unit/player/Wizard/Wizard.tscn")

func get_player_instance()->Player:
	return _player_file.instantiate()

static var player_items:Array[int] = []
