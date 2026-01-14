extends Control

@onready var stem: RichTextLabel = %Stem
@onready var answer: RichTextLabel = %Answer
@onready var v_box_container: VBoxContainer = %VBoxContainer
@onready var line_edit_1: LineEdit = %LineEdit1
@onready var line_edit_2: LineEdit = %LineEdit2
@onready var line_edit_3: LineEdit = %LineEdit3
@onready var line_edit_4: LineEdit = %LineEdit4
@onready var line_edit_5: LineEdit = %LineEdit5

var current_order:int=1

func _ready() -> void:
	_display_content()
	pass # Replace with function body.

func _display_content():
	#获取当前题目信息
	var current_content=Global.fill_content[current_order-1]
	#赋值stem
	stem.text=current_content.题型+str(current_order)+"."+current_content.题干
	#获取选项内容信息
	var blank_number:int=current_content.题干.split("）").size()-1
	for le in v_box_container.get_children():
		le.modulate=Color(1,1,1)
		le.visible=false
		le.text=""
	for index in blank_number:
		v_box_container.get_child(index).visible=true


func _on_confirm_pressed() -> void:
	#print(Global.fill_content[current_order-1].答案)
	var an:String=Global.fill_content[current_order-1].答案
	answer.text=an
	for i in an.split(";").size():
		if an.split(";")[i]==v_box_container.get_child(i).text:
			v_box_container.get_child(i).modulate=Color.AQUAMARINE
		else:
			v_box_container.get_child(i).modulate=Color.BROWN
	pass # Replace with function body.


func _on_show_pressed() -> void:
	var an:String=Global.fill_content[current_order-1].答案
	answer.text=an
	for i in an.split(";").size():
		v_box_container.get_child(i).text=an.split(";")[i]
	pass # Replace with function body.


func _on_last_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"填空题",false)
	if  state==0 or state==1:
		return
	current_order-=1
	_display_content()
	pass # Replace with function body.


func _on_next_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"填空题",true)
	if  state==0 or state==1:
		return
	current_order+=1
	#print(current_order)
	_display_content()
	pass # Replace with function body.
