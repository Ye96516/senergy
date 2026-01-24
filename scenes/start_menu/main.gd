extends ScrollContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init_item()
	pass # Replace with function body.

func _on_button_pressed(file_name:String):
	Global.init_data(Global.json_save_path.path_join(file_name))
	#await Global.data_init_finished
	get_tree().change_scene_to_file("res://scenes/fill_in/fill_in.tscn")
	pass


func _init_item():
	var paths:PackedStringArray=DirAccess.get_files_at(Global.json_save_path)
	for i in paths:
		var b:Button=Button.new()
		b.text=i
		b.custom_minimum_size=Vector2(100,225)
		v_box_container.add_child(b)
		b.pressed.connect(_on_button_pressed.bind(b.text))
#
#func _on_tab_container_tab_selected(_tab: int) -> void:
	#_init_item()
	pass # Replace with function body.
