class_name Enemy extends Unit

static func _get_player_pos()-> Vector2:
	return InstanceGetter.get_player().global_position

static func _spawn_item( id:int, pos:Vector2 )->void:
	ItemFactory.spawn(id, pos)

func get_team()->int:
	return ENEMY
