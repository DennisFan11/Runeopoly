extends ShopItem


func get_discript()->String:
	return "Vampire"

func get_price()->Array[int]:
	return [1,0,0]

func buyed(): # 吸血: 可吸取一部份傷害
	super()
