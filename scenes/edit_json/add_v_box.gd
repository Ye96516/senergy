extends VBoxContainer

@onready var current_json: Label = %CurrentJson

@onready var type_edit: TextEdit = %TypeEdit
@onready var stem_edit: TextEdit = %StemEdit
@onready var question_order_edit: TextEdit = %QuestionOrderEdit
@onready var chapter_title_edit: TextEdit = %ChapterTitleEdit
@onready var order_edit: TextEdit = %OrderEdit
@onready var content_edit: TextEdit = %ContentEdit
@onready var answer_edit: TextEdit = %AnswerEdit
@onready var custom_key: TextEdit = %CustomKey
@onready var custom_value: TextEdit = %CustomValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_json.text=Global.current_edit_json_path.get_file()
	pass # Replace with function body.


func modify_json_file(file_path: String):
	# 步骤1: 读取JSON文件
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		print("错误：无法打开文件 ", file_path, "。错误代码: ", FileAccess.get_open_error())
		return

	# 获取文件内容
	var json_string = file.get_as_text()
	file.close()

	# 步骤2: 解析JSON字符串为Godot数据字典
	var json = JSON.new()
	var parse_error = json.parse(json_string)
	if parse_error != OK:
		print("JSON解析失败: ", json.get_error_message(), "（位于行: ", json.get_error_line(), "）")
		return
	
	#若不理解就打印json.data看看
	if json.data is Array:
		var new_dic:Dictionary
		add_content(new_dic)
		json.data.append(new_dic)
	else:
		pass
		
	# 步骤4: 将数据序列化为JSON字符串，使用制表符（\t）缩进
	var new_json_string = JSON.stringify(json.data, "\t")
	# 步骤5: 将格式化后的JSON写回文件
	file = FileAccess.open(file_path, FileAccess.WRITE)
	if file == null:
		print("错误：无法以写入模式打开文件 ", file_path)
		return

	file.store_string(new_json_string)
	file.flush()  # 确保数据写入磁盘
	file.close()
	print("JSON文件已更新，使用制表符缩进。")


func add_content(dic:Dictionary):
	dic["题型"]=type_edit.text
	dic["题干"]=stem_edit.text
	dic["题号"]=question_order_edit.text
	dic["章节名"]=chapter_title_edit.text
	dic["序号"]=order_edit.text
	dic["选项内容"]=content_edit.text
	dic["答案"]=answer_edit.text
	dic[custom_key.text]=custom_value.text

#将增加json条目的textedit置空
func restore_add_eidt():
	type_edit.text=""
	stem_edit.text=""
	question_order_edit.text=""
	chapter_title_edit.text=""
	order_edit.text=""
	content_edit.text=""
	answer_edit.text=""
	custom_key.text=""
	custom_value.text=""

func _on_confirm_add_pressed() -> void:
	modify_json_file(Global.current_edit_json_path)
	restore_add_eidt()
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu/start_menu.tscn")
	pass # Replace with function body.
