extends Button

func _ready() -> void:
	$DeleteFile.current_path=Global.json_save_path

func _on_delete_file_file_selected(path: String) -> void:
	delete_json_file(path)
	pass # Replace with function body.


func _on_pressed() -> void:
	$DeleteFile.visible=true
	pass # Replace with function body.

func is_json_file(file_path: String) -> bool:
	if not FileAccess.file_exists(file_path):
		return false
	return file_path.get_extension().to_lower() == "json"


# ============================================
# 主函数：删除JSON文件
# ============================================
## 删除指定路径的文件（仅当文件类型为JSON时）
## @param file_path: 文件路径
## @return: 返回删除结果 {success: bool, message: String}
func delete_json_file(file_path: String) -> Dictionary:
	var result = {
		"success": false,
		"message": ""
	}
	
	# 检查路径是否为空
	if file_path.is_empty():
		result.message = "文件路径为空"
		return result
	
	# 检查文件是否存在
	if not FileAccess.file_exists(file_path):
		result.message = "文件不存在: " + file_path
		return result
	
	# 检查文件扩展名是否为.json
	if not is_json_file(file_path):
		result.message = "文件不是JSON类型: " + file_path
		return result
	
	# 删除文件
	var error = DirAccess.remove_absolute(file_path)
	
	if error == OK:
		result.success = true
		result.message = "JSON文件删除成功: " + file_path
	else:
		result.message = "删除失败，错误代码: " + str(error)
	
	return result
