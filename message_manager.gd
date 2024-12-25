extends Node
signal message(str:String)
func new_message(str:String):
	message.emit(str)
