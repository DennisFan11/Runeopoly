class_name Occluder extends Node2D


# Called when the node enters the scene tree for the first time.
var original = true
var node
func _ready() -> void:
	if original:
		node = self.duplicate()
		node.original = false
		$"../..".AddOcclusion(node)
		
		#self.visible = false
func _process(delta: float) -> void:
	if original:
		#scale = Vector2.ONE*2.0
		node.position = $"../..".Global2Map(self.position)
