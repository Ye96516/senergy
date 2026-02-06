extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_defalut()

func _defalut():
	for i in Global.type_order:
		var question_array:Array= Global.get_question_type_array(i)
		if question_array:
			Global.current_question=question_array[0]
			break
