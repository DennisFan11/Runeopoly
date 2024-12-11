class_name InstanceGetter
extends Object

static func set_world(world:World)->void: # 在world加載時自動寫入
	_world = world
static var _world:World
static func get_world()-> World:
	assert(is_instance_valid(_world), "from InstanceGetter: world instance not valid")
	return _world

static func set_player(player:Player)->void:
	_player = player
static var _player:Player
static func get_player()-> Player:
	assert(is_instance_valid(_player), "from InstanceGetter: player instance not valid")
	return _player


static var game_loop:GameLoopFSM
