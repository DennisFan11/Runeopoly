@icon("res://GameLoopFSM/Blocks/Components/EntryPoint/EntryPoint.png")
extends Node2D
func _ready():
	visible = Setting.get_debug()
