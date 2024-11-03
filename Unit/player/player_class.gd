class_name Player
extends Unit
func get_team()-> int: # 由子類完成 給外部的接口
	return PLAYER

const ACCELERATION = 13.5 # 百分比 
const DECELERATION = 20.0
const MAX_SPEED = 200.0
const JUMP_SPEED = -500.0
const G = 2000.0

const WALL_MAX_SPEED = MAX_SPEED/1.5
const WALL_ACCELERATION = ACCELERATION/1.5
const WALL_DECELERATION = DECELERATION/1.5

var flip:bool = false
var last_flip:bool = false

var DASH_IN_TIME:float = 0.2 # 2
var DASH_TIME:float = 0.2 # 3
var DASH_OUT_TIME:float = 0.1 # 4

const DASH_SPEED:float = MAX_SPEED*3.0

var coyote_timer:float = 0.0
const COYOTE_TIME:float = 0.2

var fall_jump_timer:float = 0.0
const FALL_JUMP_TIME:float = 0.15
func is_grab(): # 使用area2D判斷有沒有抓到牆 由子類完成
	pass
#--------------------------以上為對外接口 





func _is_grab(left:Area2D, right:Area2D)-> bool: #判斷工具
	if last_flip and left.get_overlapping_bodies().size()!= 0:
		return true
	elif right.get_overlapping_bodies().size()!= 0:
		return true
	return false

var _state: PlayerBaseState
func _ready():
	_state = PlayerIDLE.new()
func _physics_process(delta):
	coyote_timer -= delta
	fall_jump_timer -= delta
	var dir = Input.get_vector("left", "right", "up", "down")
	_state = _state.UPDATE(delta, self, dir)
	move_and_slide()
