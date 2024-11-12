class_name NumberEffect
extends CanSpawn
static func Spawn(pos:Vector2, str:String, time:float=2.0)->void:
	var instance := preload("res://Unit/Effect/Number/NumberEffect.tscn").instantiate()
	instance.position = pos
	instance.set_text(str)
	instance.set_time(time)
	
	_get_world().add_child(instance)

const MOVE_UP_VALUE = 60.0 # pix
func set_text(text:String):
	$RichTextLabel.text = "[center]"+text+"[/center]"
func set_time(time:float):
	var _tree = _get_world().get_tree()
	var tween := _tree.create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), time)
	tween = _tree.create_tween()
	tween.tween_property(self, "position", position-Vector2(0.0, MOVE_UP_VALUE), time)
	_tree.create_timer(time).timeout.connect(queue_free)# 時間到自動釋放
