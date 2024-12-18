class_name Player
extends Unit
func get_team()-> int: # 由子類完成 給外部的接口
	return PLAYER

var ACCELERATION = 13.5 # 百分比 
var DECELERATION = 20.0
var MAX_SPEED = 150.0
var JUMP_SPEED = -500.0
var G = 2000.0

var WALL_MAX_SPEED = MAX_SPEED/1.5
var WALL_ACCELERATION = ACCELERATION/1.5
var WALL_DECELERATION = DECELERATION/1.5

var flip:bool = false
var last_flip:bool = false

var DASH_IN_TIME:float = 0.2 # 2
var DASH_TIME:float = 0.2 # 3
var DASH_OUT_TIME:float = 0.1 # 4

var DASH_SPEED:float = MAX_SPEED*3.0

var coyote_timer:float = 0.0
const COYOTE_TIME:float = 0.2

var fall_jump_timer:float = 0.0
const FALL_JUMP_TIME:float = 0.15
func is_grab(): # 使用area2D判斷有沒有抓到牆 由子類完成
	pass
#--------------------------以上為對外接口

func _death(): # NOTE 死亡時自動呼叫 生命週期
	InstanceGetter.game_loop.GameOver()
	

func _is_grab(left:Area2D, right:Area2D)-> bool: #判斷工具
	if last_flip and left.get_overlapping_bodies().size()!= 0:
		return true
	elif right.get_overlapping_bodies().size()!= 0:
		return true
	return false

var _state: PlayerBaseState
func _ready():
	InstanceGetter.set_player(self)
	_state = PlayerIDLE.new()
	_enemy_scanner_init()
	
	
	
	
var REGEN = 0.0
func _physics_process(delta):
	_hp += REGEN*delta # REGEN Perk
	
	coyote_timer -= delta
	fall_jump_timer -= delta
	
	var dir = Input.get_vector("left", "right", "up", "down")
	_state = _state.UPDATE(delta, self, dir)
	move_and_slide()
	
func _enemy_scanner_init():
	_scan_area = Area2D.new()
	_scan_area.visible = false
	_scan_area.collision_layer = 3
	_scan_area.collision_mask = 3
	var coll = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 300.0
	coll.shape = shape
	_scan_area.add_child(coll)
	add_child(_scan_area)
var _scan_area:Area2D

func find_enemy(pos:Vector2)-> Unit: # 對外接口, 尋找最近的敵人
	var min_dist := 99999.0
	var min_enemy:Unit = null
	for i in _scan_area.get_overlapping_bodies():
		if i is Unit and (i as Unit).get_team()!=get_team():
			var dist := (i.global_position- pos).length()
			if dist<=min_dist:
				min_enemy = i
				min_dist = dist
	return min_enemy
