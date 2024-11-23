class_name Setting
static var _DEBUG_MODE:bool = true
static var _game_info:GameInfo


#static var _block_size:Vector2 = Vector2(64.0, 64.0)
#static var _block_count:int = 40







#static func get_block_size()-> Vector2:
	#return _block_size
#static func get_block_count()-> int:
	#return _block_count



static func get_debug()-> bool:
	return _DEBUG_MODE

static func get_game_info()-> GameInfo:
	return _game_info
