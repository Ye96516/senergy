extends ScrollContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer
var data_cache:PackedStringArray
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init_item()
	pass # Replace with function body.

func _on_button_pressed(file_name:String):
	Global.init_data(Global.json_save_path.path_join(file_name))
	get_tree().change_scene_to_file("res://scenes/main_question/main_question.tscn")
	pass


func _init_item():
	var paths:PackedStringArray=DirAccess.get_files_at(Global.json_save_path)
	#防止防止重复生成相同作用的button节点，这段return可以删除，保留的话性能应该会更好
	if v_box_container.get_child_count()>=paths.size():
		return
	for i in paths:
		#防止重复生成相同作用的button节点
		if i in data_cache:
			continue
		var b:Button=Button.new()
		b.text=i
		b.custom_minimum_size=Vector2(100,225)
		v_box_container.add_child(b)
		b.pressed.connect(_on_button_pressed.bind(b.text))
		data_cache.append(i)
#func _on_tab_container_tab_selected(_tab: int) -> void:
	#print(Global.json_save_path)
	#_init_item()
	#pass # Replace with function body.


func _on_tab_container_tab_clicked(_tab: int) -> void:
	_init_item()
	pass # Replace with function body.
