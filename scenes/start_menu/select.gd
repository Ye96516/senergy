extends Button

var selected_path:String

@onready var add_file: FileDialog = %AddFile
@onready var select_file: FileDialog = %SelectFile


func _ready() -> void:
	#创建存储目录
	if not DirAccess.dir_exists_absolute(Global.json_save_path):
		DirAccess.make_dir_absolute(Global.json_save_path)
	select_file.current_dir=Global.json_save_path


func _on_select_pressed() -> void:
	select_file.visible=true

func _on_select_file_file_selected(path: String) -> void:
	Global.current_edit_json_path=path
	get_tree().change_scene_to_file("res://scenes/edit_json/edit_json.tscn")
	pass # Replace with function body.




	
