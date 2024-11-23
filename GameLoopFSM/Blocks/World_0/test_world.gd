extends World

func _ENTER(): # 在子類複寫
	pass

func _EXIT(): # 在子類複寫
	pass


var time = 0.0
func _process(delta):
	time += delta
	if time >0.5:
		time = 0.0
		_spawn()
		
var enemy_instance = preload("res://Unit/Enemy/Skull/Skull.tscn")
func _spawn():
	var pos = _get_EnemySpawnPoints().pick_random().position
	var node = enemy_instance.instantiate()
	node.position = pos
	add_child(node)
