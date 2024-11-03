extends Node
var _player:Player
var _pos:Vector2 = Vector2.ZERO

func set_start_pos(global_pos:Vector2): # 初始化相機位置
	_pos = global_pos
	$Camera2D.offset = global_pos

func set_player(player:Player): # 設定玩家引用
	_player = player

func _ready():
	$Camera2D.enabled = true



func _process(delta):
	_pos = _player.global_position
	$Camera2D.offset = $Camera2D.offset.lerp(_pos, delta * 2.5)
