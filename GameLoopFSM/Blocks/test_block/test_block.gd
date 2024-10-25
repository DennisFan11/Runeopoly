extends Block
const size = Vector2(96, 96)
var WorldScene = preload("res://GameLoopFSM/Blocks/test_block/test_world.tscn")
func GetWorld()->World:
	return WorldScene.instantiate()
