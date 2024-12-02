@icon("res://GameLoopFSM/_World/Components/EnemySpawnPoint/EnemySpawnPoint.png")
extends Node2D
func _ready():
	visible = Setting.get_debug()
