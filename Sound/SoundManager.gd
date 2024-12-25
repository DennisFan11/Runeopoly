extends Node



enum BGM {BGM, FIGHTING_BGM}
enum EFFECT {ATTACK, BEATTACK, PLAYER_DIE, MONSTER_DIE}



var bgms = {
	BGM.BGM: preload("res://Sound/bgm.mp3"),
	BGM.FIGHTING_BGM: preload("res://Sound/打架中bgm.mp3")
}

var effects = {
	EFFECT.ATTACK: preload("res://Sound/攻擊.mp3"),
	EFFECT.BEATTACK: preload("res://Sound/被攻擊.mp3"),
	EFFECT.PLAYER_DIE: preload("res://Sound/死亡.mp3"),
	EFFECT.MONSTER_DIE: preload("res://Sound/怪物死亡.mp3")
}



	




@onready var _bgm_player := AudioStreamPlayer.new()
@onready var _effect_player := AudioStreamPlayer.new()

#var sound_arr := []
func play_effect(e:EFFECT):
	var new_sound := AudioStreamPlayer.new()
	
	new_sound.finished.connect(new_sound.queue_free)
	new_sound.stream = effects[e]
	
	add_child(new_sound)
	new_sound.play()

func play_bgm(e:BGM):
	_bgm_player.stream = bgms[e]
	_bgm_player.play()



func ui_click():
	_effect_player.stream = preload("res://Sound/UI點擊.mp3")
	_effect_player.play()


func _ready() -> void:
	add_child(_bgm_player)
	add_child(_effect_player)
	_bgm_player.finished.connect(_bgm_player.play)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		#print("click")
		ui_click()


#
