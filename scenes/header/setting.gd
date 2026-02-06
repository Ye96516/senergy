extends Panel

@onready var select_type: OptionButton = $SelectType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_select_type_item_selected(index: int) -> void:
	var type:String=select_type.get_item_text(index)
	if Global.get_question_type_array(type):
		pass
	pass # Replace with function body.


func _on_is_show_answer_toggled(toggled_on: bool) -> void:
	Global.config.show_answer=toggled_on
	pass # Replace with function body.

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			visible=false
