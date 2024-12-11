extends Line2D


var one_vec:Vector2
func _ready() -> void:
	one_vec = (Vector2(272, 49) - Vector2(210, 17)).normalized()*8.0
	var level:int = InstanceGetter.get_player()._hp/10.0
	points[1] = points[0] + level * one_vec
	

func _process(delta: float) -> void:
	var level:int = InstanceGetter.get_player()._hp/10.0
	points[1] = points[0] + level * one_vec
