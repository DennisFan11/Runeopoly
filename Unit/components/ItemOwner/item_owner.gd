extends Node2D # ItemOwner

func _process(delta: float) -> void:
	var list:Array[ShopItem] = []
	for i:Node2D in $Area2D.get_overlapping_areas():
		if i.is_in_group("ShopItem"):
			list.append(i.get_parent() as ShopItem)
	if list.size()!=0:
		var own_item:Array[int] = [] # 擁有物品檢查
		own_item.resize(50)
		for i:Item in item_arr:
			own_item[i.ID] += 1
		#print("own:", own_item)
		
		var clost_item:ShopItem = list[0] # 尋找最近ShopItem
		for i in range(list.size()):
			var new_len = (list[i].position-InstanceGetter.get_player().position).length()
			var old_len = (clost_item.position-InstanceGetter.get_player().position).length()
			if new_len >= old_len:
				clost_item = list[i]
				
		var can_buy:bool = true # 價格檢查
		var cost = clost_item.get_price()
		#print("cost:", cost)
		for i in range(cost.size()):
			if cost[i] > own_item[i]:
				can_buy = false
				break
		clost_item.can_buy(can_buy)
		if Input.is_action_just_pressed("item_switch") and can_buy: # 購買物品
			var remove_list:Array[Item] = []
			for ID in range(cost.size()):
				var mount = cost[ID]
				if mount == 0:
					continue
				for item:Item in item_arr:
					if mount == 0:
						break
					if item.ID == ID:
						remove_list.append(item)
						mount-=1
			for i in remove_list:
				item_arr.erase(i)
				i.set_state(Item.USED)
				i.EndTarget = clost_item.position
			_curr_item = _curr_item
			clost_item.buyed()
			
		

func _exit_tree() -> void: # 存入道具
	var item_list:Array[int] = []
	for i:Item in item_arr:
		item_list.append(i.ID)
	GameInfo.player_items = item_list

func _ready() -> void: # 提取道具
	for i in GameInfo.player_items:
		await get_tree().create_timer(0.1).timeout
		ItemFactory.spawn(i, global_position)
	await get_tree().create_timer(0.5).timeout
	_grab_item()




func _physics_process(delta: float) -> void:
	Item.player_pos = global_position


enum {IDLE, CONNECTED_IDLE, SELECT, CHARGING, USED}

func _grab_item():
	for i in $Area2D.get_overlapping_bodies():
		_check(i)

func _check(body:Node2D): # FIXME
	if Input.is_action_pressed("item_grab") and body.is_in_group("Item"):
		var item = body.get_parent() as Item
		if not (item in item_arr) and item._state == Item.IDLE:
			item.set_state(Item.CONNECTED_IDLE)
			item_arr.append(item)


var item_arr:Array[Item]
var _curr_item:int = -1:
	set(new):
		if new >= item_arr.size():
			_curr_item = 0
		else:
			_curr_item = new
	get():
		if item_arr.size()==0: # no item 
			_curr_item = -1
			return _curr_item
		else: # have item
			_curr_item = clampi(_curr_item, 0, item_arr.size()-1)
			return _curr_item
		
func _next_item(): # 下一個
	if item_arr.size()==0:
		return
	if _curr_item!= -1:
		item_arr[_curr_item].set_state(Item.CONNECTED_IDLE)
	_curr_item += 1
	item_arr[_curr_item].set_state(Item.SELECT)
func _drop_item(): # 移除連結
	if _curr_item == -1: # no item 
		return 
	item_arr.pop_at(_curr_item).set_state(Item.IDLE)
	_curr_item = _curr_item
	if _curr_item == -1: # no item 
		return 
	item_arr[_curr_item].set_state(Item.SELECT)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("item_switch"):
		_next_item()
		#print(_curr_item)
		#print(item_arr)
	elif event.is_action_pressed("item_drop"):
		_drop_item()
	elif event.is_action_pressed("item_grab"):
		_grab_item()










#
