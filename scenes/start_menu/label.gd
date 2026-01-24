extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	await get_tree().create_timer(0.5).timeout
	if not DirAccess.dir_exists_absolute(Global.json_save_path):
		text="用户json存储路径未创建"
		return
	else:
		text="json存储路径已创建"
	text=str(DirAccess.get_files_at(Global.json_save_path))

		
	pass
