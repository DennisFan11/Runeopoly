extends Weapon
const CD = 0.1
var scene = preload("res://Unit/Weapon/bullets/NormalBullet/NormalBullet.tscn")
func _fire(dir:Vector2): # 由子類複寫
	if _in_cd:
		return
	_in_cd = true
	get_tree().create_timer(CD).timeout.connect(_cd_over)
	#print("fire")
	SoundManager.play_effect(SoundManager.EFFECT.ATTACK)
	var node:Bullet = scene.instantiate()
	node.Spawn(%Marker2D.global_position, dir.normalized(), PLAYER)
	_get_world().add_child(node)
	
	

func _physics_process(delta):
	rotation = _attacking_dir().angle()
	super(delta)
var _in_cd:bool = false
func _cd_over():
	_in_cd = false
#
