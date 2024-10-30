class_name GameLoopFSM
extends Node2D

#region 對外接口
func LOOP_ENTER():
	_ENTER()
signal LOOP_EXIT
#endregion

@onready var _GameBoard := $GameBoard # 負責Block和,走格子動畫 MOVE
@onready var _world := $World # 負責World的生成 EXPLORE
@onready var _UI := $UI # Board UI ROLL

#signal ROLL_EXIT
#signal MOVE_EXIT
#signal EXPLORE_EXIT

func _ENTER():
	Setting._game_info = GameInfo.new()
	_GameBoard.gen_block()
	
	_UI.ROLL_EXIT.connect(_MOVE_ENTER) # 必須附帶骰子點數
	_GameBoard.MOVE_EXIT.connect(_EXPLORE_ENTER)
	_world.EXPLORE_EXIT.connect(_ROLL_ENTER)
	_ROLL_ENTER()
	
func _EXIT():
	LOOP_EXIT.emit()
	
func _ROLL_ENTER():
	$Camera2D.enabled = true
	_UI.ROLL_ENTER()
	_test_state = ROLL
func _MOVE_ENTER(num:int):
	_GameBoard.MOVE_ENTER(num)
	_test_state = MOVE
func _EXPLORE_ENTER(world:World):
	$Camera2D.enabled = false
	_world.EXPLORE_ENTER(world)
	_test_state = EXPLORE
	
enum {ROLL=0, MOVE=1, EXPLORE=2}


var _test_state = EXPLORE:
	set(new):
		#print("switch ", _test_state, " to ", new)
		var next = _test_state+1
		if next==3:
			next = 0
		assert(new==next, "from GameLoopFSM: State error")
		_test_state = new
		
func _get_test_state():
	return _test_state

func _process(delta):
	$Camera2D.offset = $Camera2D.offset.lerp(_GameBoard.get_player_pos(), delta*4.5)
