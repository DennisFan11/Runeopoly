extends FlyEnemy


func _ready() -> void:
	DMG = 200.0
	#set_nav_agent($NavigationAgent2D)
	set_attack_area($AttackArea)
	super()

func _death(): # NOTE 死亡時自動呼叫 生命週期
	if randf_range(0.0, 1.0) < GOLD_LEVEL:
		_spawn_item(2, position)
	super()
