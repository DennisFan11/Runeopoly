class_name ShopItem extends Node2D


func get_price()->Array[int]:
	return []

func buyed():
	queue_free()

func get_discript()->String:
	return "Test"

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



var _discriptLabel:RichTextLabel
var _price_bar:VBoxContainer
var _area:Area2D
func _ready() -> void:
	scale = Vector2.ONE /2.0
	_discriptLabel = RichTextLabel.new()
	_discriptLabel.bbcode_enabled = true
	_discriptLabel.position = Vector2(-150, -80)
	_discriptLabel.size = Vector2(300, 25)
	_discriptLabel.visible = false
	add_child(_discriptLabel)
	
	_price_bar = VBoxContainer.new()
	_price_bar.visible = false
	_price_bar.alignment = BoxContainer.ALIGNMENT_CENTER
	_price_bar.size = Vector2(200, 40)
	_price_bar.position = Vector2(-100, -60)
	add_child(_price_bar)
	for node in _get_price_icon(get_price()):
		_price_bar.add_child(node)
	
	_area = Area2D.new()
	var coll = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 20.0
	coll.shape = shape
	_area.add_child(coll)
	_area.collision_layer = 128
	_area.collision_mask = 128
	add_child(_area)
	
	_area.area_shape_entered.connect(_on_area_2d_area_shape_entered)
	_area.area_shape_exited.connect(_on_area_2d_area_shape_exited)
	


func can_buy(can:bool):
	if !is_queued_for_deletion():
		if can:
			_discriptLabel.text = "[center][color=green]"+get_discript()+"[/color][/center]"
		else:
			_discriptLabel.text = "[center][color=red]"+get_discript()+"[/color][/center]"

var _view: bool
func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Buyer") and !is_queued_for_deletion():
		_view = true
		_price_bar.visible = _view
		_discriptLabel.visible = _view


func _on_area_2d_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Buyer") and !is_queued_for_deletion():
		_view = false
		_price_bar.visible = _view
		_discriptLabel.visible = _view



#
