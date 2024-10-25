@tool
extends Node2D
signal MOVE_EXIT
func MOVE_ENTER(num:int): # 移動棋子和玩家
	await _move(num) 
func _EXIT():   # ATTENTION 呼叫狀態結束 並回傳世界
	#print("_blocks: ", _blocks, "pos:", player_pos)
	MOVE_EXIT.emit(_blocks[player_pos].GetWorld())
	
func gen_block(): # 生成地塊
	_gen_test_block() # TEST
func get_player_pos()-> Vector2:
	return player.global_position
#-----------------------------------------對外接口-------------------
func _get_setting_block_size()->Vector2:
	if Engine.is_editor_hint():
		return Vector2(64.0, 64.0)
	return Setting.get_block_size()
func _get_setting_block_count()->int:
	if Engine.is_editor_hint():
		return 40
	return Setting.get_block_count()
func _get_setting_move_time()-> float:
	return Setting.get_move_time()

func _ready():
	_curve_init()
	if Engine.is_editor_hint():
		_gen_test_block()

func _curve_init(): # 初始化block放置輔助線
	$Path2D.curve.clear_points()
	var r := _get_setting_block_size().x *  _get_setting_block_count()/ 4.0
	var square:Array[Vector2] = [
		Vector2(0, 0),
		Vector2(r, 0),
		Vector2(r, r),
		Vector2(0, r),
		Vector2(0, 0)
	]
	for i in square:
		$Path2D.curve.add_point(i)

func _get_block_pos(block_num:int)-> Vector2: # 放置block的座標
	$Path2D/PathFollow2D.progress_ratio = float(block_num) / _get_setting_block_count()
	return $Path2D/PathFollow2D.position

#region TEST

var _blocks:Array[Block] = []
@onready var scene = preload("res://GameLoopFSM/Blocks/test_block/test_block.tscn") # TEST
func _gen_test_block(): # TEST
	var BLOCK_COUNT:int = _get_setting_block_count()
	for i in range(BLOCK_COUNT):
		var node = scene.instantiate()
		var pos:Vector2 = _get_block_pos(i)
		node.position = pos
		$Block.add_child(node)
		_blocks.append(node)
	
func _move(num:int):
	for i in range(num):
		await _walk()
	_EXIT() # ATTENTION

@onready var player = $player_icon
var player_pos:int = 0:
	set(new):
		if new>=_get_setting_block_count():
			new -= _get_setting_block_count()
		player_pos = new
		assert(player_pos>=0 and player_pos<=_get_setting_block_count(),
			"from GameBoard: player_pos 移動出界")

func _walk(): # 移到下一格
	var TIME = _get_setting_move_time() # 移動時間
	player_pos += 1
	var tween = get_tree().create_tween()
	
	tween.tween_property(player, "position", _get_block_pos(player_pos), TIME)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT) # 動畫
	await get_tree().create_timer(TIME).timeout # 等待動畫結束
#endregion
