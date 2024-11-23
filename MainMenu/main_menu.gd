extends Node


@onready var _GameLoop := $GameLoopFSM
func _ready() -> void:
	_GameLoop.LOOP_EXIT.connect(_game_end)
	_enter_menu()
	
	

var _started: bool = false
func _game_start():
	if _started:
		return
	$Camera2D.enabled = false
	_started = true
	$CanvasLayer.visible = false
	_GameLoop.LOOP_ENTER()

func _game_end():
	$Camera2D.enabled = true
	_started = false
	_enter_menu()

func _enter_menu():
	$CanvasLayer.visible = true
	$CanvasLayer/AnimationPlayer.play("Enter")


func _on_start_button_pressed() -> void:
	$CanvasLayer/AnimationPlayer.play("Enter", -1, -2.0, true)
	get_tree().create_timer(2.0).timeout.connect(_game_start)


func _on_setting_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()

@onready var _PlayerIconList := [%PlayerStartIcon, %PlayerSettingIcon, %PlayerQuitIcon]

func _set_icon(id:int):
	for i:Node2D in _PlayerIconList:
		i.visible = false
	_PlayerIconList[id].visible = true

func _on_start_button_mouse_entered() -> void:
	_set_icon(0)


func _on_setting_button_mouse_entered() -> void:
	_set_icon(1)


func _on_quit_button_mouse_entered() -> void:
	_set_icon(2)
