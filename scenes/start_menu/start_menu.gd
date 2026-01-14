extends Control

@onready var add_file: FileDialog = %AddFile
@onready var select_file: FileDialog = %SelectFile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _on_b_2024_pressed() -> void:
	#Global.json_data="res://data/2024.json"
	#Global.clear_data()
	#Global.init_data()
	#get_tree().change_scene_to_file("res://scenes/fill_in/fill_in.tscn")
	#$FileDialog.visible=true
	pass # Replace with function body.


func _on_add_pressed() -> void:
	add_file.visible=true
	pass # Replace with function body.

func _on_add_file_file_selected(path: String) -> void:
	#创建存储目录
	if not DirAccess.dir_exists_absolute(Global.json_save_path):
		DirAccess.make_dir_absolute(Global.json_save_path)
	#生成存储文件路径
	var save_path:String=Global.json_save_path.path_join(path.get_file())
	#若该文件已存在则退出
	if ResourceLoader.exists(save_path):
		print("文件已存在")
		return
	var error=DirAccess.copy_absolute(path,save_path)
	if error!=OK:
		print(error)
	pass # Replace with function body.
