@tool
class_name BlockPortal extends Block
static var _portal_list:Array[BlockPortal] = []
func _ready() -> void:
	super()
	_portal_list.append(self)
	var save:Array[BlockPortal] = []
	for i in _portal_list:
		if is_instance_valid(i):
			save.append(i)
		_portal_list = save
	


func blockEvent():
	print("BlockEvent")
	var connected_Portal:BlockPortal = _portal_list.pick_random()
	await PortalLine.set_pos(position, connected_Portal.position)
	GameBoard.set_player_pos(connected_Portal.pos)
	super()










#
