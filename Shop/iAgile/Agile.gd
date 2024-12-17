extends ShopItem


func get_discript()->String:
	return "Agile"

func get_price()->Array[int]:
	return [1,0,0]

func buyed(): # 敏捷: 加快移動速度, 衝刺cd 縮短
	super()
