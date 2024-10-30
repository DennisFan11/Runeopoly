class_name Enemy
extends Unit
static var _player_instance:Player
static func _get_player_pos()-> Vector2:
	if is_instance_valid(_player_instance):
		return _player_instance.position
	return Vector2.ZERO
func get_team()->int:
	return ENEMY
	
