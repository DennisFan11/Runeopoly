extends AnimatedSprite2D
var time = 0.0
var origin:Vector2
func _ready():
	origin = position
	play("default")
func _process(delta):
	time += delta
	position.y = origin.y + sin(time*15.0 )*5.0
