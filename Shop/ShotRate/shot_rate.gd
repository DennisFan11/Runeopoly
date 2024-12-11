extends ShopItem
func _ready() -> void:
	$RichTextLabel.visible = false
	%PriceBar.visible = false
	for node in _get_price_icon(get_price()):
		%PriceBar.add_child(node)

func get_price()->Array[int]:
	return [1,0,0]

func buyed():
	super()

func can_buy(can:bool):
	if !is_queued_for_deletion():
		if can:
			$RichTextLabel.text = "[center][color=green]Speed Rate[/color][/center]"
		else:
			$RichTextLabel.text = "[center][color=red]Speed Rate[/color][/center]"




var _view: bool
func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Buyer") and !is_queued_for_deletion():
		_view = true
		%PriceBar.visible = _view
		$RichTextLabel.visible = _view


func _on_area_2d_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Buyer") and !is_queued_for_deletion():
		_view = false
		%PriceBar.visible = _view
		$RichTextLabel.visible = _view
