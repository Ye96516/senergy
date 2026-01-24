extends Button

var path="/storage/emulated/0/Android/data/com.example.senergy/a/1.txt"

func _on_pressed() -> void:
	var err=DirAccess.make_dir_absolute("/storage/emulated/0/Android/data/com.example.senergy/a")
	#var file = FileAccess.open(path, FileAccess.WRITE)
	$Label.text=str(err)
	
	#if DirAccess.dir_exists_absolute("user://123"):
		#$Label.text="已存在"
	#else:
		#$Label.text=err
	pass # Replace with function body.
