extends Control

@export var return1_text:String
@export var setting_text:String
@export var chapter_text:String
@export_file var return_path:String

@onready var h_box_container: HBoxContainer = %HBoxContainer
@onready var return1_button: Button = %Return
@onready var setting_button: Button = %Setting
@onready var chapter_name: RichTextLabel = %ChapterName
@onready var setting: Panel = $Setting

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.question_changed.connect(_on_changed)
	pass # Replace with function body.

func init_data():
	return1_button.text=return1_text
	setting_button.text=setting_text
	
func _on_return_pressed() -> void:
	Global.clear_data()
	get_tree().change_scene_to_file(return_path)
	pass # Replace with function body.


func _on_setting_pressed() -> void:
	setting.visible=true
	pass # Replace with function body.

func _on_changed(_a):
	if Global.current_question.has("章节名"):
		chapter_name.text=Global.current_question["章节名"]
