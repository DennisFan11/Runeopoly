extends Control

func _ready() -> void:
	MessageManager.message.connect(add_text)
var arr = []
func add_text(str:String):
	var node = RichTextLabel.new()
	node.bbcode_enabled = true
	node.custom_minimum_size.y = 25.0
	node.text = str
	%VBoxContainer.add_child(node)
	arr.append(node)
	print("new message!", str)
	if arr.size()>=10:
		arr.pop_front().queue_free()
		
