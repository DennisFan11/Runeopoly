class_name PathfindingServer extends Node

@onready var _mainViewport = %MainViewport
@onready var _occlusionGroup = %OcclusionGroup
@onready var _buffer = %Buffer


func _ready() -> void:
	ReSize(Vector2.ONE*512.0, Vector2.ONE*64.0)

## 
func AddOcclusion(node:Node2D):
	%OcclusionGroup.add_child(node)

##
func SetTarget(position:Vector2):
	%TargetRect.position = position

## 從GPU獲取圖像
var _img:Image
func _get_img():
	_img = _buffer.get_viewport().get_texture().get_image()
	print("img update")

# Bilinear sampling function in GDScript
func get_pixel_bilinear(img: Image, vec:Vector2) -> Color:
	var x:float = vec.x
	var y:float = vec.y
	# Ensure the coordinates are within bounds
	var width: int = img.get_width()
	var height: int = img.get_height()

	x = clamp(x, 0.0, float(width - 1))
	y = clamp(y, 0.0, float(height - 1))

	# Identify the integer floor and ceiling of x, y
	var x_floor: int = int(floor(x))
	var y_floor: int = int(floor(y))
	var x_ceil: int = min(x_floor + 1, width  - 1)
	var y_ceil: int = min(y_floor + 1, height - 1)

	# Calculate the fractional part of x, y (how far into each pixel we are)
	var dx = x - float(x_floor)
	var dy = y - float(y_floor)

	# Sample the four surrounding pixels:
	# (x_floor, y_floor), (x_ceil, y_floor),
	# (x_floor, y_ceil),  (x_ceil, y_ceil)
	var c00: Color = img.get_pixel(x_floor, y_floor)
	var c10: Color = img.get_pixel(x_ceil,  y_floor)
	var c01: Color = img.get_pixel(x_floor, y_ceil)
	var c11: Color = img.get_pixel(x_ceil,  y_ceil)

	# Lerp horizontally between c00 and c10, then between c01 and c11
	var c0: Color = c00.lerp(c10, dx)
	var c1: Color = c01.lerp(c11, dx)

	# Lerp vertically between the two horizontal blends
	return c0.lerp(c1, dy)

## 輸入世界座標 返回採樣的向量 TODO
func SampVector(position:Vector2)-> Vector2:
	if !_img:
		return Vector2.ZERO
	var fix_pos = Global2Map(position) + _resolution/2.0
	print("pos = ", fix_pos)
	var c:Color = get_pixel_bilinear(_img, fix_pos)
	return Vector2(c.r, c.g)


var _origin_size:Vector2i = Vector2.ONE*512.0
var _resolution:Vector2i = Vector2.ONE*512.0

func ReSize( origin_size:Vector2i, resolution:Vector2i )-> void:
	_origin_size = origin_size
	_resolution = resolution
	_mainViewport.size = resolution
	_buffer.size = resolution
	%MainCamera2D.zoom = Vector2(resolution)/Vector2(origin_size)
	%BufferCamera2D.zoom = Vector2(resolution)/Vector2(origin_size)
	%FromBuffer.scale = Vector2(origin_size)/Vector2(resolution)
	%FromMain.scale = Vector2(origin_size)/Vector2(resolution)
	#print(Vector2(resolution)/Vector2(origin_size))


func Global2Map(position:Vector2)-> Vector2:
	return position * Vector2(_resolution)/Vector2(_origin_size)
