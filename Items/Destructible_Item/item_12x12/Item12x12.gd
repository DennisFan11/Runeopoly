class_name Item12x12 extends Destructible_Item

func set_item_sprite(texture:Texture2D):
	$RigidBody2D/ItemSprite.texture = texture


func _IDLE(delta: float)-> void:
	super(delta)
	_glow(false)
func _CONNECTED_IDLE(delta: float)-> void: # 取消發光
	super(delta)
	_glow(false)
func _SELECT(delta: float)-> void: # 啟用發光
	super(delta)
	_glow(true)
func _USED(delta: float):
	super(delta)
	_glow(false)

func _glow(enable:bool):
	$RigidBody2D/SelectSprite.visible = enable
