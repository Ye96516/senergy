extends Control

@onready var stem: RichTextLabel = %Stem
@onready var answer: RichTextLabel = %Answer

var current_order:int=1

func _ready() -> void:
	_display_content()
	pass # Replace with function body.

func _display_content():
	#获取当前题目信息
	var current_content=Global.brief_content[current_order-1]
	#赋值stem
	stem.text=current_content.题型+str(current_order)+"."+current_content.题干
	
	answer.text=current_content.答案


func _on_last_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"简答题",false)
	if  state==0 or state==1:
		return
	current_order-=1
	_display_content()
	pass # Replace with function body.


func _on_next_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"简答题",true)
	if  state==0 or state==1:
		return
	current_order+=1
	_display_content()
	pass # Replace with function body.
