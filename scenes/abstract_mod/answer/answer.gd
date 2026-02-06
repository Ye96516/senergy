extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.answered_correctly.connect(_on_correct)
	Global.answered_incorrectly.connect(_on_incorrect)
	Global.question_changed.connect(_on_changed)
	pass # Replace with function body.

func _on_correct():
	show_current_answer()
	pass

func _on_incorrect():
	show_current_answer()
	pass

func _on_changed(_a):
	if Global.config.show_answer:
		show_current_answer()
	else:
		hide_current_answer()

func show_current_answer():
	visible=true
	text=Global.current_question.答案

func hide_current_answer():
	visible=false
	text=""
