extends ShopItem


func get_discript()->String:
	return "GoldenTouch"

func get_price()->Array[int]:
	return [1,0,0]

func buyed(): # 黃金之觸：擊敗敵人後，敵人掉落的金幣增加。疊加後掉落率和金幣量進一步提升。
	super()
