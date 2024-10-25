extends Node2D
# NOTE 再生成完世界後 等待時間結束 然後結束狀態 
var _world:World

signal EXPLORE_EXIT
func EXPLORE_ENTER(world:World):
	if is_instance_valid(_world):
		_world.queue_free()
	_world = world
	add_child(world)
	get_tree().create_timer(Setting.get_explore_time()).timeout.connect(_EXIT)
func _EXIT(): # ATTENTION 狀態結束
	EXPLORE_EXIT.emit()
