extends Node2D

var arr:Array[PackedScene]= [
	preload("res://Shop/iAgile/Agile.tscn"),
	preload("res://Shop/iGoldenTouch/GoldenTouch.tscn"),
	preload("res://Shop/iRegeneration/Regeneration.tscn"),
	preload("res://Shop/iToxicSpread/ToxicSpread.tscn"),
	preload("res://Shop/iVampire/Vampire.tscn"),
	preload("res://Shop/iLightningChain/LightningChain.tscn")
]
func _ready() -> void:
	var node = arr.pick_random().instantiate()
	node.position = position
	get_parent().call_deferred("add_child", node)
