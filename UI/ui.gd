extends CanvasLayer
signal RollDice
enum {ROLL_DICE, PLAYER_MOVE, EXPLORE}




func _on_button_pressed() -> void:
	if State.state == ROLL_DICE:
		State.state = PLAYER_MOVE
		var num = randi_range(1, 6)
		RollDice.emit(num)
		$Control/Label.text = str(num)
		
