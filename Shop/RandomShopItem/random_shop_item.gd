extends Node2D

var arr:Array[PackedScene]= [
	preload("res://Shop/ShotRate/ShotRate.tscn")
]
func _ready() -> void:
	var node = arr.pick_random().instantiate()
	node.position = position
	get_parent().call_deferred("add_child", node)
