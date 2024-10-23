extends Block
const size = Vector2(96, 96)
var WorldScene = preload("res://Blocks/terrain_block/terrain_world.tscn")
func GetWorld():
	return WorldScene.instantiate()
