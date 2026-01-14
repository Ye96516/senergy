extends ScrollContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var paths:PackedStringArray=DirAccess.get_files_at(Global.json_save_path)
	for i in paths:
		var b:Button=Button.new()
		b.text=i
		b.custom_minimum_size=Vector2(100,225)
		v_box_container.add_child(b)
	pass # Replace with function body.
