extends ShopItem


func get_discript()->String:
	return "Vampire"

func get_price()->Array[int]:
	return [1,1,0]

func buyed(): # 吸血: 可吸取一部份傷害
	Enemy.VAMPIRE_PERK += 0.1
	MessageManager.new_message("[color=green]Player buyed \"Vampire\"[/color]")
	super()
