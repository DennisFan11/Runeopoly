
extends Node2D
const count:int = 40 # block 的數量

@onready var player = $player_icon

var player_pos:int = 0: # 玩家座標
	set(new):
		if new >= count:
			player_pos = new- count
		else:
			player_pos = new



func _ready() -> void:
	_gen_map()
	$UI.RollDice.connect(_RollDice)
	player.position = _get_point(player_pos/float(count))


func _RollDice(moves:int):
	for i in range(moves):
		await _walk()
	State.state = State.ROLL_DICE


func _walk(): # 移到下一格
	player_pos += 1
	var tween = get_tree().create_tween()
	tween.tween_property(
		player,
		"position",
		_get_point(player_pos/float(count)), 0.5
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(0.5).timeout




var block_arr:Array[Block] = []

func _process(delta: float) -> void:
	
	for i in range(count):
		block_arr[i].position = _get_point(i/ float(count))
	$Camera2D.offset = lerp($Camera2D.offset, $player_icon.position, 4.0 * delta) # 移動攝影機





var block_scene:PackedScene = preload("res://Blocks/terrain_block/terrain_block.tscn")
@onready var mount_node := $block_container

func _gen_map(): # 生成地圖
	for i in mount_node.get_children(): # 清除既有節點
		i.queue_free()
	
	for i in range(count):
		_add_block(_get_point(i/ float(count)))

func _get_point(progress:float):
	$Path2D/PathFollow2D.progress_ratio = progress
	return $Path2D/PathFollow2D.global_position



func _add_block(pos:Vector2):
	var node:Node2D = block_scene.instantiate()
	node.position = pos
	mount_node.add_child(node)
	block_arr.append(node)






#
