extends Polygon2D
var time:float = 0.0

func _process(delta: float) -> void:
	time += delta*10
	scale.x = sin(time)
