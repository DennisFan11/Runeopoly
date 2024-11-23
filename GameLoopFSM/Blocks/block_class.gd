@tool
class_name Block extends Node2D

@export var texture:Texture2D
@export var world:PackedScene


var _world:World
func GetWorld()-> World:
	if _world:
		return _world
	_world = world.instantiate()
	return _world


#region stacked sprite
const BLOCK_SIZE = Vector2(16, 16)
const SPRITE_SIZE = Vector2(256, 16)

const IMG_COUNT:int = SPRITE_SIZE.x / BLOCK_SIZE.x


var _sprite_arr: Array[Sprite2D] = []

func _set_sprite( _text:Texture2D )-> Array[Sprite2D]:
	var _node_arr:Array[Sprite2D]
	var img = _text.get_image()
	
	for _x in range(IMG_COUNT-1, -1, -1):
		var new_img:Image = img.get_region( Rect2i(Vector2i(_x*BLOCK_SIZE.x, 0), BLOCK_SIZE) )
		var new_node:Sprite2D = Sprite2D.new()
		new_node.texture = ImageTexture.create_from_image(new_img)
		_node_arr.append(new_node)
	
	return _node_arr

func _ready() -> void:
	if texture:
		scale = Vector2.ONE * 4.0
		_sprite_arr = _set_sprite(texture)
		for i in _sprite_arr:
			add_child(i)

func get_editor_screen_center():
	var viewport = EditorInterface.get_editor_viewport_2d()
	var global_canvas_transform = viewport.global_canvas_transform
	var viewport_rect = viewport.get_visible_rect()
	
	# Calculate screen center in global coordinates
	var screen_center = global_canvas_transform.affine_inverse() * (viewport_rect.size / 2.0)
	
	return screen_center

func _process(delta: float) -> void:
	if texture:
		var camera_pos:Vector2
		if Engine.is_editor_hint():
			camera_pos = get_editor_screen_center()
		else:
			camera_pos = get_viewport().get_camera_2d().get_screen_center_position()
		#print("camera_pos = ", camera_pos)
		
		
		var offset = to_local(camera_pos)
		offset = offset.normalized() * clampf(offset.length()/50.0, 0.0, 0.7)*-1 # /100
		var new_pos = Vector2.ZERO
		for i:Node2D in _sprite_arr:
			i.position = new_pos
			new_pos += offset
	

#endregion
















#
