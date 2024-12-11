class_name ItemFactory extends RefCounted
enum {IORN, STONE, WOOD}

static var item12x12 = preload("res://Items/Destructible_Item/item_12x12/Item12x12.tscn")
static var file := {
	IORN:preload("res://Items/ItemFactory/asset/Iorn.png"),
	STONE:preload("res://Items/ItemFactory/asset/Stone.png"),
	WOOD:preload("res://Items/ItemFactory/asset/Wood.png")
}
static func spawn(id:int, pos:Vector2)->void:
	var item:Item12x12 = item12x12.instantiate()
	item.ID = id
	item.set_item_sprite(file[id])
	item.set_pos(pos)
	InstanceGetter.get_world().call_deferred("add_child", item)

static func get_icon(id:int)->Texture2D: # ShopItem
	return file[id]
