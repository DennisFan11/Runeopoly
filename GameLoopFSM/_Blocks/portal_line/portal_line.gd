class_name PortalLine  extends Node2D
static var _self:PortalLine
func _ready() -> void:
	_self = self
	_self.visible = false

static func set_pos(A:Vector2, B:Vector2):
	
	_self._set_pos(A, B)
	_self._ani()
	const TIME = 5.0
	var tween = _self.get_tree().create_tween()
	_self.shader_w = 0.0
	tween.tween_property(_self, "shader_w", 1.0, TIME)
	await _self.get_tree().create_timer(TIME).timeout # 前動畫
	var tween2 = _self.get_tree().create_tween()
	tween2.tween_property(_self, "shader_w", 0.0, 0.5)
	_self._end_ani(0.5)

var shader_w:float:
	set(new):
		shader_w = new
		$Line2D.material.set_shader_parameter("width", new)

func _set_pos(A:Vector2, B:Vector2):
	$Line2D.points = PackedVector2Array([A, B])
func _ani():
	_self.visible = true
func _end_ani(TIME:float):
	await _self.get_tree().create_timer(TIME).timeout # 前動畫
	_self.visible = false
