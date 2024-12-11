extends FlyEnemy




func _ready() -> void:
	set_nav_agent($NavigationAgent2D)
	set_attack_area($AttackArea)

func _death(): # NOTE 死亡時自動呼叫 生命週期
	_spawn_item(1, position)
	super()
