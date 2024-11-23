extends Control

const ROLL_TIME:float = 3.0

signal EXIT



func ENTER():
	$AnimationPlayer.play("Enter")
	visible = true
	_roll_dice()
	%RollNumber.text = "Roll: " + str(_rolled_number)
func _EXIT():
	EXIT.emit(_rolled_number)


var _rolled_number = 0
func _roll_dice():
	_rolled_number = randi_range(1, 12) # 設置隨機數
	get_tree().create_timer(ROLL_TIME).timeout.connect(_EXIT) # TEST








func CUT_SCENE_ENTER():
	$AnimationPlayer.play("Cutscene")
	get_tree().create_timer(1.5).timeout.connect(_center)

signal CUT_SCENE_CENTER
func _center():
	CUT_SCENE_CENTER.emit()
	$AnimationPlayer.play_backwards("Cutscene")
	get_tree().create_timer(1.5).timeout.connect(_CUT_SCENE_EXIT)

func _CUT_SCENE_EXIT():
	visible = false
	CUT_SCENE_EXIT.emit()

signal CUT_SCENE_EXIT














#
