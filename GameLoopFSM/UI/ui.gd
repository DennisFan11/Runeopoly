extends Control

const ROLL_TIME:float = 1.0

signal EXIT



func ENTER():
	$AnimationPlayer.play("Enter")
	%RollButton.text = "Roll"
	%RollButton.disabled = false
	visible = true
	
var _rolled_number = 0
func _on_roll_button_pressed() -> void:
	%RollButton.disabled = true
	var _count:int = 30
	var _time:float = 0.03
	if Setting.DEBUG:
		_count = 1
	for i in range(_count):
		get_tree().create_timer(i * _time).timeout.connect(_random_roll)
	get_tree().create_timer(_count * _time).timeout.connect(_roll_dice)
	

func _random_roll():
	%RollButton.text = "Roll:" + str(randi_range(1, 12))
	
func _roll_dice():
	_rolled_number = randi_range(1, 12) # 設置隨機數
	if _is_select():
		_rolled_number = _selectNum
	%RollButton.text = "Roll:" + str(_rolled_number)
	get_tree().create_timer(ROLL_TIME).timeout.connect(_EXIT) # TEST
	

func _EXIT():
	EXIT.emit(_rolled_number)












func CUT_SCENE_ENTER():
	var time = 1.5
	if Setting.DEBUG:
		time = 0.0
	$AnimationPlayer.play("Cutscene")
	get_tree().create_timer(time).timeout.connect(_center)

signal CUT_SCENE_CENTER
func _center():
	var time = 1.5
	if Setting.DEBUG:
		time = 0.0
	CUT_SCENE_CENTER.emit()
	$AnimationPlayer.play_backwards("Cutscene")
	get_tree().create_timer(time).timeout.connect(_CUT_SCENE_EXIT)

func _CUT_SCENE_EXIT():
	visible = false
	CUT_SCENE_EXIT.emit()

signal CUT_SCENE_EXIT













var _selectNum:int = -1
var _enable_select:bool

func _is_select()-> bool:
	return _enable_select and _selectNum != -1


#
func _selcetNum()-> int:
	if _enable_select:
		var text:String = %NumberInput.text
		if text.is_valid_int():
			return int(text)
	return -1
		

func _on_check_box_toggled(toggled_on: bool) -> void:
	_enable_select = toggled_on
	%NumberInput.visible = toggled_on
	_selectNum = _selcetNum()
		
	
func _on_number_input_text_changed(new_text: String) -> void:
	_selectNum = _selcetNum()
