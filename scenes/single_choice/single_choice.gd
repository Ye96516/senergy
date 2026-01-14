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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_display_data()
	pass # Replace with function body.


func _display_data():
	#获取当前题目信息
	var current_content=Global.single_content[current_order-1]
	#赋值stem
	stem.text=current_content.题型+str(current_order)+"."+current_content.题干
	#获取选项内容信息
	var option_content:Array=current_content.选项内容.split(";")

	for button in v_box_container.get_children():
		button.visible=false
		button.modulate=Color(1,1,1)
		button.set_pressed(false)
		answer.text=""
	for index in option_content.size():
		v_box_container.get_child(index).visible=true
		v_box_container.get_child(index).text=option_content[index]
		pass
	


func _on_button_a_toggled(toggled_on: bool) -> void:
	answer.text=Global.single_content[current_order-1].答案
	if Global.single_content[current_order-1].答案=="A" and toggled_on:
		button_a.modulate=Color.AQUAMARINE
	elif toggled_on==false:
		button_a.modulate=Color(1,1,1,1)
	elif Global.single_content[current_order-1].答案!="A" and toggled_on:
		button_a.modulate=Color.BROWN
	pass # Replace with function body.


func _on_button_b_toggled(toggled_on: bool) -> void:
	answer.text=Global.single_content[current_order-1].答案
	if Global.single_content[current_order-1].答案=="B" and toggled_on:
		button_b.modulate=Color.AQUAMARINE
	elif toggled_on==false:
		button_b.modulate=Color(1,1,1,1)
	elif Global.single_content[current_order-1].答案!="B" and toggled_on:
		button_b.modulate=Color.BROWN
		
func _on_button_c_toggled(toggled_on: bool) -> void:
	answer.text=Global.single_content[current_order-1].答案
	if Global.single_content[current_order-1].答案=="C" and toggled_on:
		button_c.modulate=Color.AQUAMARINE
	elif toggled_on==false:
		button_c.modulate=Color(1,1,1,1)
	elif Global.single_content[current_order-1].答案!="C" and toggled_on:
		button_c.modulate=Color.BROWN


func _on_button_d_toggled(toggled_on: bool) -> void:
	answer.text=Global.single_content[current_order-1].答案
	if Global.single_content[current_order-1].答案=="D" and toggled_on:
		button_d.modulate=Color.AQUAMARINE
	elif toggled_on==false:
		button_d.modulate=Color(1,1,1,1)
	elif Global.single_content[current_order-1].答案!="D" and toggled_on:
		button_d.modulate=Color.BROWN

func _on_button_e_toggled(toggled_on: bool) -> void:
	answer.text=Global.single_content[current_order-1].答案
	if Global.single_content[current_order-1].答案=="E" and toggled_on:
		button_e.modulate=Color.AQUAMARINE
	elif toggled_on==false:
		button_e.modulate=Color(1,1,1,1)
	elif Global.single_content[current_order-1].答案!="E" and toggled_on:
		button_e.modulate=Color.BROWN

func _on_button_f_toggled(toggled_on: bool) -> void:
	answer.text=Global.single_content[current_order-1].答案
	if Global.single_content[current_order-1].答案=="F" and toggled_on:
		button_f.modulate=Color.AQUAMARINE
	elif toggled_on==false:
		button_f.modulate=Color(1,1,1,1)
	elif Global.single_content[current_order-1].答案!="F" and toggled_on:
		button_f.modulate=Color.BROWN


func _on_last_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"单选题",false)
	if  state==0 or state==1:
		return
	current_order-=1
	_display_data()

func _on_next_pressed() -> void:
	var state:int=Global.to_new_type(current_order,"单选题",true)
	if  state==0 or state==1:
		return
	current_order+=1
	_display_data()
