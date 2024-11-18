extends Destructible_Item
func _IDLE(delta: float)-> void:
	super(delta)
	_glow(false)
func _CONNECTED_IDLE(delta: float)-> void: # 取消發光
	super(delta)
	_glow(false)
func _SELECT(delta: float)-> void: # 啟用發光
	super(delta)
	_glow(true)


func _glow(enable:bool):
	$RigidBody2D/ItemSelect.visible = enable
