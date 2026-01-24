extends Control

@onready var add_file: FileDialog = %AddFile
@onready var select_file: FileDialog = %SelectFile
@onready var tab_container: TabContainer = $TabContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#创建存储目录
	if not DirAccess.dir_exists_absolute(Global.json_save_path):
		DirAccess.make_dir_absolute(Global.json_save_path)
	tab_container.set_tab_title(0,"首页")
	tab_container.set_tab_title(1,"编辑页面")
	pass

func _on_add_pressed() -> void:
	add_file.visible=true
	pass # Replace with function body.

func _on_add_file_file_selected(path: String) -> void:
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
