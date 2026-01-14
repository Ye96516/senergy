extends ScrollContainer

@onready var button_v_box: VBoxContainer = %ButtonVBox
var json_data:Array

func _ready() -> void:
	json_data=_json_data(Global.current_edit_json_path)
	#展示删除画面
	if json_data is Array:
		for i in json_data:
			var b:Button=Button.new()
			b.alignment=HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT
			b.text=JSON.stringify(i)
			#print(JSON.stringify(i))
			b.custom_minimum_size=Vector2(600,125)
			button_v_box.add_child(b)
			b.pressed.connect(_on_b_pressed.bind(i,b))
		
func _on_b_pressed(dic:Dictionary,self_button:Button):
	var err=DisplayServer.dialog_show(
		"删除提示","是否删除该项内容？",["确认","取消"],
		func(index:int):
			match index:
				0:
					delete_dict_from_json_array(Global.current_edit_json_path,dic)
					self_button.visible=false
	)
	if err!=OK:
		print(err)
	pass

func delete_dict_from_json_array(file_path: String, target_dict: Dictionary) -> bool:
	# 2. 查找并删除目标字典[6](@ref)
	var original_size = json_data.size()
	# 使用逆序循环避免删除元素时索引错位
	for i in range(json_data.size() - 1, -1, -1):
		if json_data[i] == target_dict:  # 直接比较字典内容
			json_data.remove_at(i)
			print("找到并删除了目标字典")
			break  # 如果只删除第一个匹配项就跳出循环
	
	var deleted_count = original_size - json_data.size()
	if deleted_count == 0:
		print("未找到匹配的字典")
		return false
	
	# 3. 将修改后的数据写回文件，使用制表符缩进[1,2](@ref)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file == null:
		push_error("无法以写入模式打开文件")
		return false
	
	# 使用制表符\t进行格式化[2,4](@ref)
	var new_json_string = JSON.stringify(json_data, "\t")
	file.store_string(new_json_string)
	file.close()
	
	print("成功删除了 " + str(deleted_count) + " 个字典，文件已更新")
	return true

#从指定路径中解析出json中的数据
func _json_data(file_path:String):
	# 1. 读取并解析JSON文件[1](@ref)
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_error("无法打开文件: " + file_path)
		return false
	
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		push_error("JSON解析错误: " + json.get_error_message())
		return false
	return json.data	
	

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu/start_menu.tscn")
	pass # Replace with function body.
