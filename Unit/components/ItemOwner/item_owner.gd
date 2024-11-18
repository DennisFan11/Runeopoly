extends Node2D # ItemOwner





func _physics_process(delta: float) -> void:
	Item.player_pos = global_position


enum {IDLE, CONNECTED_IDLE, SELECT, CHARGING, USED}

func _grab_item():
	for i in $Area2D.get_overlapping_bodies():
		_check(i)

func _check(body:Node2D): # FIXME
	if Input.is_action_pressed("item_grab") and body.is_in_group("Item"):
		var item = body.get_parent() as Item
		if not (item in item_arr):
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
		print(_curr_item)
		print(item_arr)
	elif event.is_action_pressed("item_drop"):
		_drop_item()
	elif event.is_action_pressed("item_grab"):
		_grab_item()










#
