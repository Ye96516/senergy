extends Control

@onready var button_a: Button = %ButtonA
@onready var button_b: Button = %ButtonB
@onready var button_c: Button = %ButtonC
@onready var button_d: Button = %ButtonD
@onready var button_e: Button = %ButtonE
@onready var button_f: Button = %ButtonF
@onready var stem: RichTextLabel = %Stem
@onready var answer: RichTextLabel = %Answer
@onready var v_box_container: VBoxContainer = %VBoxContainer

var current_order:int=1
var correct_time:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_display_content()
	pass # Replace with function body.

func _display_content():
	#获取当前题目信息
	var current_content=Global.multiple_content[current_order-1]
	#赋值stem
	stem.text=current_content.题型+str(current_order)+"."+current_content.题干
	#获取选项内容信息
	var option_content:Array=current_content.选项内容.split(";")
	#重置正确按钮的点击次数，用于正确答案都被选中后显示答案
	correct_time=0
	
	for button in v_box_container.get_children():
		button.visible=false
		button.modulate=Color(1,1,1)
		button.set_pressed(false)
		answer.text=""
	for index in option_content.size():
		v_box_container.get_child(index).visible=true
		v_box_container.get_child(index).text=option_content[index]
		pass
	#print(current_content.答案.split(";"))

func _on_button_a_pressed() -> void:
	if "A" in Global.multiple_content[current_order-1].答案:
		button_a.modulate=Color.AQUAMARINE
		correct_time+=1
		if Global.multiple_content[current_order-1].答案.split(";").size()==correct_time:
			answer.text=Global.multiple_content[current_order-1].答案
	else:
		button_a.modulate=Color.BROWN
		answer.text=Global.multiple_content[current_order-1].答案
	pass # Replace with function body.


func _on_button_b_pressed() -> void:
	if "B" in Global.multiple_content[current_order-1].答案:
		button_b.modulate=Color.AQUAMARINE
		correct_time+=1
		if Global.multiple_content[current_order-1].答案.split(";").size()==correct_time:
			answer.text=Global.multiple_content[current_order-1].答案
	else:
		button_b.modulate=Color.BROWN
		answer.text=Global.multiple_content[current_order-1].答案
	pass # Replace with function body.


func _on_button_c_pressed() -> void:
	if "C" in Global.multiple_content[current_order-1].答案:
		button_c.modulate=Color.AQUAMARINE
		correct_time+=1
		if Global.multiple_content[current_order-1].答案.split(";").size()==correct_time:
			answer.text=Global.multiple_content[current_order-1].答案
	else:
		button_c.modulate=Color.BROWN
		answer.text=Global.multiple_content[current_order-1].答案
	pass # Replace with function body.


func _on_button_d_pressed() -> void:
	if "D" in Global.multiple_content[current_order-1].答案:
		button_d.modulate=Color.AQUAMARINE
		correct_time+=1
		if Global.multiple_content[current_order-1].答案.split(";").size()==correct_time:
			answer.text=Global.multiple_content[current_order-1].答案
	else:
		button_d.modulate=Color.BROWN
		answer.text=Global.multiple_content[current_order-1].答案
	pass # Replace with function body.


func _on_button_e_pressed() -> void:
	if "E" in Global.multiple_content[current_order-1].答案:
		button_e.modulate=Color.AQUAMARINE
		correct_time+=1
		if Global.multiple_content[current_order-1].答案.split(";").size()==correct_time:
			answer.text=Global.multiple_content[current_order-1].答案
	else:
		button_e.modulate=Color.BROWN
		answer.text=Global.multiple_content[current_order-1].答案
	pass # Replace with function body.


func _on_button_f_pressed() -> void:
	if "F" in Global.multiple_content[current_order-1].答案:
		button_f.modulate=Color.AQUAMARINE
		correct_time+=1
		if Global.multiple_content[current_order-1].答案.split(";").size()==correct_time:
			answer.text=Global.multiple_content[current_order-1].答案
	else:
		button_f.modulate=Color.BROWN
		answer.text=Global.multiple_content[current_order-1].答案
	pass # Replace with function body.


func _on_last_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"多选题",false)
	if  state==0 or state==1:
		return
	#print(Global.multiple_content.size())
	current_order-=1
	#print(current_order)
	_display_content()
	pass # Replace with function body.


func _on_next_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"多选题",true)
	if  state==0 or state==1:
		return
	#print(Global.multiple_content.size())
	current_order+=1
	#print(current_order)
	_display_content()
	pass # Replace with function body.
