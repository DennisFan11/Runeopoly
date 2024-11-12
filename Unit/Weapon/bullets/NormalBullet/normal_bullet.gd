extends Bullet
func Spawn(pos:Vector2, dir:Vector2, team:int=PLAYER)-> void:
	super(pos, dir, team)
	
func _handle(old:int, delta:float):
	$Area2D/Icon.material.set_shader_parameter("direction", _dir)
	const SPEED:float = 450.0
	match old:
		FLY: # 飛行狀態
			position += _dir * SPEED * delta
		HIT: # 擊中
			pass

func _get_damage()-> float:
	return 30.0
func _get_force()-> float:
	return 450.0
func _on_area_2d_body_entered(body:Node2D):
	
	if _check_hit(body):
		_state = HIT
		_kill_process()

var _killed:bool = false
func _kill_process(): #　自毀流程
	if !_killed:
		_killed = true
		const END_TIME = 0.5
		var tween := get_tree().create_tween()
		tween.tween_property(self, "strength", 40.0, END_TIME)
		
		get_tree().create_timer(END_TIME).timeout.connect(queue_free)
		
var strength:float = 0.3:
	set(new):
		$Area2D/Icon.material.set_shader_parameter("strength", new)
		strength = new
