extends Control
signal ROLL_EXIT
func ROLL_ENTER():
	_roll_dice()
func _EXIT():
	ROLL_EXIT.emit(_rolled_number)


var _rolled_number = 0
func _roll_dice():
	_rolled_number = randi_range(1, 12) # 設置隨機數
	get_tree().create_timer(Setting.get_roll_time()).timeout.connect(_EXIT) # TEST
