extends VBoxContainer

@onready var option_question: VBoxContainer = self


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	Global.question_changed.connect(_question_changed)
	
	pass # Replace with function body.


func _question_changed(question:Dictionary):
	_clear()
	if question.选项内容=="" and question.题型!="判断题":
		return
	match question.题型:
		"单选题":
			var options:Array=question.选项内容.split(";")
			_create_buttons(options,_on_single_pressed)
			
		"多选题":
			var options:Array=question.选项内容.split(";")
			_create_buttons(options,_on_multiple_pressed)
		"判断题":
			_create_buttons(["对","错"],_on_multiple_pressed)
			pass
	pass

func _on_single_pressed(content:String,button:Button):
	if content[0]==Global.current_question.答案:
		#选中的按钮变色
		button.modulate=Color.AQUAMARINE
		#发送信号
		Global.answered_correctly.emit()
		#未选中的按钮刷新
		for i in button.get_parent().get_children():
			if i==button:
				continue
			else:
				i.modulate=Color.ALICE_BLUE
	else:
		button.modulate=Color.BROWN
		Global.answered_incorrectly.emit()
		for i in button.get_parent().get_children():
			if i==button:
				continue
			else:
				i.modulate=Color.ALICE_BLUE

var number:int
func _on_multiple_pressed(content:String,button:Button):
	if content[0] in Global.current_question.答案 and button.modulate!=Color.AQUAMARINE:
		number+=1
		if number==Global.current_question.答案.length():
			Global.answered_correctly.emit()
		button.modulate=Color.AQUAMARINE
	else:
		button.modulate=Color.BROWN
		Global.answered_incorrectly.emit()

func _on_tf_pressed(content:String,button:Button):
	if content==Global.current_question.答案:
		#选中的按钮变色
		button.modulate=Color.AQUAMARINE
		#发送信号
		Global.answered_correctly.emit()
		#未选中的按钮刷新
		for i in button.get_parent().get_children():
			if i==button:
				continue
			else:
				i.modulate=Color.ALICE_BLUE
	else:
		button.modulate=Color.BROWN
		Global.answered_incorrectly.emit()
		for i in button.get_parent().get_children():
			if i==button:
				continue
			else:
				i.modulate=Color.ALICE_BLUE

func _clear():
	for i in option_question.get_children():
		i.queue_free()

##生成按钮并绑定对应方法
func _create_buttons(content:Array,sig:Callable):
	for option in content:
		var button:Button=Button.new()
		button.text=option
		button.custom_minimum_size.y=80
		button.mouse_filter=Control.MOUSE_FILTER_PASS
		button.autowrap_mode=TextServer.AUTOWRAP_WORD
		if content==["对","错"]:
			button.alignment=HORIZONTAL_ALIGNMENT_CENTER
		else:
			button.alignment=HORIZONTAL_ALIGNMENT_LEFT
		button.pressed.connect(sig.bind(option,button))
		option_question.add_child(button)
