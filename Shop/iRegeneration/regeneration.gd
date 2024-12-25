extends ShopItem


func get_discript()->String:
	return "Regeneration"

func get_price()->Array[int]:
	return [1,0,2]

func buyed(): # 再生力：每隔一定時間恢復一定比例的生命值。疊加後，恢復速度和恢復量提升。
	InstanceGetter.get_player().REGEN += 10
	MessageManager.new_message("[color=green]Player buyed \"Regeneration\"[/color]")
	super()
