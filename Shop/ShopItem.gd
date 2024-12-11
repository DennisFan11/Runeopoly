class_name ShopItem extends Node2D


func get_price()->Array[int]:
	return []

func buyed():
	queue_free()


func can_buy(can:bool):
	pass

func _get_price_icon(price:Array[int])-> Array[Control]: # 生成價格表
	var arr:Array[Control] = []
	for id in range(price.size()):
		var mount:int = price[id]
		if mount != 0:
			var icon = TextureRect.new()
			icon.texture = ItemFactory.get_icon(id)
			icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
			var num = Label.new()
			num.text = ":"+str(mount)
			arr.append_array([icon, num])
	return arr

#
