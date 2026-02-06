extends RichTextLabel

func _ready() -> void:
	Global.question_changed.connect(_question_changed)

func _question_changed(question:Dictionary):
	text="[color=orange]"+question.题型+"[/color]"+str(Global.get_question_order(question))+"."+\
	question.题干
