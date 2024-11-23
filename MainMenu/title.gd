@tool
extends RichTextLabel


var _rot:float = -0.116937
var _time = 0.0
func _process(delta: float) -> void:
	_time += delta
	scale = Vector2.ONE * (1.0 + 0.05 + sin(_time*8.0)*0.05)
	rotation = _rot + sin(_time*2.0)*0.1
