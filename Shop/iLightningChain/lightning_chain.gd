extends ShopItem


func get_discript()->String:
	return "LightningChain"

func get_price()->Array[int]:
	return [1,1,1]

func buyed(): # LightningChain
	#Enemy.GOLD_LEVEL += 0.5
	LightningChain.LEVEL += 0.5
	NormalBullet.lightningChain = true
	MessageManager.new_message("[color=green]Player buyed \"LightningChain\"[/color]")
	super()
