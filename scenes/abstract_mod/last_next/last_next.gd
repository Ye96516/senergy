extends HBoxContainer

@export var answer:RichTextLabel

func _on_last_pressed() -> void:
	to_last_question()


func _on_next_pressed() -> void:
	to_next_question()

##改变答案显示状态
func _on_show_answer_pressed() -> void:
	if answer.visible==true:
		answer.hide_current_answer()
	else:
		answer.show_current_answer()

func to_last_question():
	var lib:Array=Global.get_current_question_type_array()
	var order:int=Global.get_current_question_order()
	if order<=1:
		var last_type:String=Global.get_current_last_type()
		if not last_type:
			return
		var last_type_content:Array=Global.get_question_type_array(last_type)
		Global.current_question=last_type_content[last_type_content.size()-1]
	else:
		Global.current_question=lib[order-2]
	pass # Replace with function body.

func to_next_question():
	var lib:Array=Global.get_current_question_type_array()
	var order:int=Global.get_current_question_order()
	if order>=lib.size():
		var next_type:String=Global.get_current_next_type()
		if not next_type:
			return
		#print(Global.get_current_next_type())
		var next_type_content:Array=Global.get_question_type_array(next_type)
		Global.current_question=next_type_content[0]
	else:
		
		Global.current_question=lib[order]
