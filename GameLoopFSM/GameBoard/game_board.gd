@tool # GameBoard
extends Node2D
const MOVE_TIME = 0.5 # 棋子移動一格所花的時間
const BLOCK_COUNT = 50


signal EXIT
func ENTER(num:int): # 移動棋子和玩家
	await _move(num)
func _EXIT():   # ATTENTION 呼叫狀態結束 並回傳世界
	#print("_blocks: ", _blocks, "pos:", player_pos)
	EXIT.emit(_blocks[player_pos].GetWorld())
	



func gen_block(): # 生成地塊
	_gen_test_block() # TEST
func get_player_pos()-> Vector2:
	return player.global_position
#-----------------------------------------對外接口-------------------

func _get_setting_move_time()-> float:
	return MOVE_TIME

func _ready():
	if Engine.is_editor_hint():
		_gen_test_block()

#---------------------------------------------------------



func _get_block_pos(block_num:int)-> Vector2: # 放置block的座標
	$Path2D/PathFollow2D.progress_ratio = float(block_num) / BLOCK_COUNT
	return $Path2D/PathFollow2D.position
func _get_block_normal(block_num:int)-> float: # 放置block的座標
	$Path2D/PathFollow2D.progress_ratio = float(block_num) / BLOCK_COUNT
	return $Path2D/PathFollow2D.rotation

#region TEST

var _blocks:Array[Block] = []
var Scenes:Array[Block]=[]

func _gen_test_block(): # TEST
	for i in %BlockType.get_children():
		Scenes.append(i)
		print(i)
	print(Scenes)
	for i in range(BLOCK_COUNT):
		var node:Block = Block.new()
		var scene = Scenes.pick_random()
		node.texture = scene.texture
		node.world = scene.world
		node.position = _get_block_pos(i)
		node.rotation = _get_block_normal(i)
		$Block.add_child(node)
		_blocks.append(node)
	
func _move(num:int):
	for i in range(num):
		await _move_to_next_block()
	_EXIT() # ATTENTION

@onready var player = $player_icon
var player_pos:int = 0:
	set(new):
		if new>=BLOCK_COUNT:
			new = 0
		player_pos = new
		assert(player_pos>=0 and player_pos<=BLOCK_COUNT,
			"from GameBoard: player_pos 移動出界")

func _move_to_next_block(): # 移到下一格
	var TIME = _get_setting_move_time() # 移動時間
	player_pos += 1
	var tween = get_tree().create_tween()
	
	tween.tween_property(player, "position", _get_block_pos(player_pos), TIME)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT) # 動畫
	await get_tree().create_timer(TIME).timeout # 等待動畫結束
	

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		for i in range(BLOCK_COUNT):
			_blocks[i].position = _get_block_pos(i)
			_blocks[i].rotation = _get_block_normal(i)


#endregion
