class_name Setting
static var _DEBUG_MODE:bool = true
static var _game_info:GameInfo

static var _roll_time:float = 3.0

static var _block_size:Vector2 = Vector2(64.0, 64.0)
static var _block_count:int = 40
static var _move_time:float = 0.5 # 棋子移動一格所花的時間

static var _explore_time:float = 30.0





static func get_roll_time()-> float:
	return _roll_time

static func get_block_size()-> Vector2:
	return _block_size
static func get_block_count()-> int:
	return _block_count
static func get_move_time()-> float:
	return _move_time

static func get_explore_time()-> float: # 獲取移動時間
	return _explore_time

static func get_debug()-> bool:
	return _DEBUG_MODE

static func get_game_info()-> GameInfo:
	return _game_info

#region TEST
static func set_all_time(time:float):
	_roll_time = 0.0
	_move_time = 0.0
	#_explore_time = time
#endregion
