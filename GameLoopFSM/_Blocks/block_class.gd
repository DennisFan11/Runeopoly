@tool
class_name Block extends Node2D


@export var world:PackedScene # 
var _world:World # 儲存的世界實例
var pos:int 
func GetWorld()-> World:
	if _world:
		return _world
	if world:
		_world = world.instantiate()
		return _world
	return null
func blockEvent():
	await get_tree().create_timer(1.0)

#region stacked sprite area


@export var texture:Texture2D:
	set(new):
		texture = new
		_set_sprite()
@export var size:Vector3i = Vector3(16, 16, 16): # 圖片的尺寸
	set(new):
		size = new
		_set_sprite()

func _ready() -> void:
	#scale = Vector2.ONE * 4.0
	for i in get_children():
		i.queue_free()
	_sprite_list = []
	_set_sprite()

var _generating:bool = false
var _sprite_list:Array[Sprite2D] = [] # sprite list

func _set_sprite(): # 在參數改變時重新生成sprite
	if texture.get_width() != size.x or texture.get_height() != size.y * size.z:
		return  # 不合規
	
	_generating = true
	for i:Sprite2D in _sprite_list:
		i.queue_free()
	var img = texture.get_image()
	for _y in range(size.z-1, -1, -1):
		var new_img:Image = img.get_region( Rect2i(Vector2i(0, _y*size.y), Vector2i(size.x, size.y)) )
		var new_node:Sprite2D = Sprite2D.new()
		new_node.texture = ImageTexture.create_from_image(new_img)
		add_child(new_node)
		_sprite_list.append(new_node)
	_generating = false

func _get_editor_screen_center(): # 螢幕中心位置
	var viewport = EditorInterface.get_editor_viewport_2d()
	var global_canvas_transform = viewport.global_canvas_transform
	var viewport_rect = viewport.get_visible_rect()
	var screen_center = global_canvas_transform.affine_inverse() * (viewport_rect.size / 2.0)
	return screen_center

func _process(delta: float) -> void: # 子圖片offset
	if _sprite_list.size() != 0 and !_generating:
		var camera_pos:Vector2
		if Engine.is_editor_hint():
			camera_pos = _get_editor_screen_center()
		else:
			camera_pos = get_viewport().get_camera_2d().get_screen_center_position()
		
		
		var offset = to_local(camera_pos) * -1
		offset = offset.normalized() * clampf(offset.length()/35.0, 0.0, 0.7)
		var new_pos = Vector2.ZERO
		for i:Node2D in _sprite_list:
			i.position = new_pos
			new_pos += offset

#endregion










#
