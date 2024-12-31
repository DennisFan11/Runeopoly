extends Node2D
signal finish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_show_text()


var text = [
	"歡迎，孩子，來到這個充滿奇蹟與魔法的世界！", 
	"你或許已經感覺到了，黑暗正在逼近……是的\n葛林戴華德正在集結他的追隨者，試圖將巫師世界置於他的掌控之下。",
	"但別擔心，我們並不孤單。當我發現你時，我就知道——即便你曾經是麻瓜\n你體內的魔法天賦卻無比耀眼，甚至超越了許多天生的巫師。",
	"現在，是時候展現你的力量了。勇敢地站起來，和我一起\n擊敗那些黑暗的爪牙，守護我們共同的家園吧！相信我，你的到來，將成為這場戰鬥的轉折點。",
	"請幫我拯救這美麗的魔法世界吧"
]
func _show_text():
	for i in text:
		%Label.text = i
		await get_tree().create_timer(5.0).timeout
	finish.emit()
