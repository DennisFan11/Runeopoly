@icon("res://GameLoopFSM/Blocks/Components/EnemySpawnPoint/EnemySpawnPoint.png")
extends Node2D
func _ready():
	visible = Setting.get_debug()
