class_name GameLoopFSM
extends Node2D

#region 對外接口
func _ready() -> void:
	visible = false
	$Background.visible = false
	$Camera2D.enabled = false
	$CanvasLayer.visible = false
	$Camera2D.zoom = Vector2.ONE * 1.5
	InstanceGetter.game_loop = self
func LOOP_ENTER():
	visible = true
	$Background.visible = true
	$Camera2D.enabled = true
	$CanvasLayer.visible = true
	_ENTER()
signal LOOP_EXIT



func GameOver():
	InstanceGetter.get_world().EXIT()
	LOOP_EXIT.emit()
	
#endregion



@onready var _GameBoard := $GameBoard # 負責Block和,走格子動畫 MOVE
@onready var _WorldContainer := $WorldContainer # 負責World的生成 EXPLORE
@onready var _UI := $CanvasLayer/UI # Board UI ROLL


func _ENTER():
	Setting._game_info = GameInfo.new()
	_GameBoard.gen_block()
	
	_UI.EXIT.connect(_UI_ROLL_finish)
	_GameBoard.EXIT.connect(_GAMEBOARD_MOVE_finish)
	_UI.CUT_SCENE_EXIT.connect(_CUTSCENE_finish)
	_UI.CUT_SCENE_CENTER.connect(_CutSceneCenter)
	_WorldContainer.EXIT.connect(_EXPLORE_finish)

	_state = -1
	_update()

func _EXIT(): # WARNING unfinish
	LOOP_EXIT.emit()

enum {UI_ROLL, GAMEBOARD_MOVE, CUTSCENE, EXPLORE}
var _state:int

var _dice_num:int
var _world:World

func _update(): # state ENTER
	_state += 1
	if _state >3:
		_state = 0
	
	match _state:
		UI_ROLL:
			SoundManager.play_bgm(SoundManager.BGM.BGM)
			_GameBoard.visible = true
			$Camera2D.enabled = true
			pass
			_UI.ENTER()
		GAMEBOARD_MOVE:
			_GameBoard.ENTER(_dice_num)
		CUTSCENE:
			if _world:
				_UI.CUT_SCENE_ENTER()
			else:
				_state = EXPLORE
				_update()
		EXPLORE:
			SoundManager.play_bgm(SoundManager.BGM.FIGHTING_BGM)
			pass

func _CutSceneCenter():
	_GameBoard.visible = false
	$Camera2D.enabled = false # from EXPLORE
	_WorldContainer.ENTER(_world) # from EXPLORE

func _UI_ROLL_finish(num:int):
	_dice_num = num
	_update()
func _GAMEBOARD_MOVE_finish(world:World):
	_world = world
	_update()
func _CUTSCENE_finish():
	_update()
func _EXPLORE_finish():
	_update()

func _input(event):
	if event.is_action_pressed("zoom_in"):
		get_viewport().get_camera_2d().zoom *= 1.1
	elif event.is_action_pressed("zoom_out"):
		get_viewport().get_camera_2d().zoom *= 0.9

func _process(delta):
	$Camera2D.offset = $Camera2D.offset.lerp(_GameBoard.get_player_pos()+Vector2(0.0, 75.0), delta*4.5) # 75
