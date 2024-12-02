extends Node2D
signal BattleExit


func _on_exit_button_pressed() -> void:
	BattleExit.emit()
