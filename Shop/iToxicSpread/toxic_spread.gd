extends ShopItem


func get_discript()->String:
	return "ToxicSpread"

func get_price()->Array[int]:
	return [1,1,0]

func buyed(): # **毒霧擴散**：擊敗敵人後釋放毒霧，使範圍內敵人持續受到毒性傷害。疊加後，毒霧範圍和持續時間增加。
	Enemy.TOXIC_PERK = true
	ToxicArea.LEVEL += 1
	MessageManager.new_message("[color=green]Player buyed \"ToxicSpread\"[/color]")
	super()
