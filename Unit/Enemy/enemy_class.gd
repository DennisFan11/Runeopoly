class_name Enemy extends Unit

static func _get_player_pos()-> Vector2:
	return InstanceGetter.get_player().global_position

static func _spawn_item( id:int, pos:Vector2 )->void:
	ItemFactory.spawn(id, pos)

func get_team()->int:
	return ENEMY

static var VAMPIRE_PERK:float = 0.0
static var TOXIC_PERK:bool = false
func hurt(value: float, guard_time:float=0.0): # 重寫
	InstanceGetter.get_player()._hp += value*VAMPIRE_PERK
	super(value, guard_time)

static var GOLD_LEVEL = 0.2

func _death():
	if TOXIC_PERK:
		var node = preload("res://Unit/Weapon/bullets/ToxicSpread/ToxicSpread.tscn")
		var ins = node.instantiate()
		ins.position = position
		InstanceGetter.get_world().call_deferred("add_child", ins)
	super()
