extends Control

@onready var stem: RichTextLabel = %Stem
@onready var answer: RichTextLabel = %Answer
@onready var trueb: Button = %True
@onready var falseb: Button = %False

var current_order:int=1

func _ready() -> void:
	_display_content()
	pass # Replace with function body.

func _display_content():
	#print(current_order)
	#获取当前题目信息
	var current_content=Global.judgment_content[current_order-1]
	#赋值stem
	stem.text=current_content.题型+str(current_order)+"."+current_content.题干
	
	trueb.modulate=Color(1,1,1)
	falseb.modulate=Color(1,1,1)

func _on_last_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"判断题",false)
	if  state==0 or state==1:
		return
	current_order-=1
	_display_content()
	pass # Replace with function body.


func _on_next_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"判断题",true)
	if  state==0 or state==1:
		return
	current_order+=1
	_display_content()
	pass # Replace with function body.


func _on_true_pressed() -> void:
	falseb.modulate=Color(1,1,1)
	if Global.judgment_content[current_order-1].答案=="对":
		trueb.modulate=Color.AQUAMARINE
	else:
		trueb.modulate=Color.BROWN
	#print(Global.judgment_content[current_order-1].答案)
	pass # Replace with function body.


func _on_false_pressed() -> void:
	trueb.modulate=Color(1,1,1)
	if Global.judgment_content[current_order-1].答案=="错":
		falseb.modulate=Color.AQUAMARINE
	else:
		falseb.modulate=Color.BROWN
	pass # Replace with function body.
