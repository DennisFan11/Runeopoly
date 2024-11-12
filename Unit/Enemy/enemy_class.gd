class_name Enemy extends Unit

static func _get_player_pos()-> Vector2:
	return InstanceGetter.get_player().global_position
func get_team()->int:
	return ENEMY
	
