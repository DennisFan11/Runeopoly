extends Node2D
@export var SpawnTime:float = 3.0
@export var ItemScene:PackedScene
var _time:float = 0.0
func _process(delta: float) -> void:
	_time += delta
	if _time >= SpawnTime:
		_spawn()
		_time = 0.0
func _spawn():
	var node:Item = ItemScene.instantiate()
	node.set_pos(position)
	get_parent().add_child(node)
