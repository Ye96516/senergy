extends Node

const json_save_path:String="user://json_data"
var json_dat:String=("res://data/2024.json")

##所有数据
var all_content:Array
##单选数据
var single_content:Array
##判断数据
var judgment_content:Array
##多选数据
var multiple_content:Array
##简答数据
var brief_content:Array
##填空数据
var fill_content:Array
##题目顺序
var question_order:Array=["填空题","单选题","多选题","判断题","简答题"]

##当前选择编辑的json
var current_edit_json_path:String

func _ready() -> void:
	init_data(json_dat)

func init_data(json_data:String):
	var a=load_json_file(json_data)[0]
	all_content=a
	for content in a:
		match content.题型:
			"填空题":
				fill_content.append(content)
			"单选题":
				single_content.append(content)
			"多选题":
				multiple_content.append(content)
			"判断题":
				judgment_content.append(content)
			"简答题":
				brief_content.append(content)

func clear_data():
	fill_content.clear()
	single_content.clear()
	multiple_content.clear()
	judgment_content.clear()
	brief_content.clear()

func load_json_file(path:String):
	if ResourceLoader.exists(path):
		var read_file=FileAccess.open(path,FileAccess.READ)
		var paresd_file=JSON.parse_string(read_file.get_as_text())
		if paresd_file is Dictionary:
			return [paresd_file,"dic"]
		elif   paresd_file is Array:
			return [paresd_file,"array"]
		else:
			printerr("出现错误，该数据不为字典也不为字典")
	else:
		printerr("文件路径错误")

##跳转新的场景题型
func to_new_type(current_order:int,type:String,is_plus:bool):
	#匹配题型
	match type:
		"单选题":
			#获取当前题型的顺序
			var type_index:int=question_order.find("单选题")
			#若题号小于等于一，并且是去上一题
			if current_order<=1 and not is_plus:
				#若该题型顺序为0，即第一个题型，则return
				if type_index==0:
					return 0
				#若该题型顺序不为0，则进入上一个题型
				to_certain_question(question_order[type_index-1])
				#代表已经执行跳转，各场景不要展示数据了
				return 1
			#若该题号小于
			
			elif current_order>=single_content.size() and is_plus:
				if type_index==question_order.size()-1:
					return 0
				to_certain_question(question_order[type_index+1])
				return 1
		"多选题":
			var type_index:int=question_order.find("多选题")
			if current_order<=1 and not is_plus:
				if type_index==0:
					return 0
				to_certain_question(question_order[type_index-1])
				return 1
			elif current_order>=multiple_content.size() and is_plus:
				if type_index==question_order.size()-1:
					return 0
				to_certain_question(question_order[type_index+1])
				return 1
		"简答题":
			var type_index:int=question_order.find("简答题")
			if current_order<=1 and not is_plus:
				if type_index==0:
					return 0
				to_certain_question(question_order[type_index-1])
				return 1
			elif current_order>=brief_content.size() and  is_plus:
				if type_index==question_order.size()-1:
					return 0
				to_certain_question(question_order[type_index+1])
				return 1
		"判断题":
			var type_index:int=question_order.find("判断题")
			if current_order<=1 and not is_plus:
				if type_index==0:
					return 0
				to_certain_question(question_order[type_index-1])
				return 1
			elif current_order>=judgment_content.size() and  is_plus:
				if type_index==question_order.size()-1:
					return 0
				to_certain_question(question_order[type_index+1])
				return 1
		"填空题":
			#print(fill_content)
			var type_index:int=question_order.find("填空题")
			if current_order<=1 and not is_plus:
				if type_index==0:
					return 0
				to_certain_question(question_order[type_index-1])
				return 1
			#若题号达到当前题型数组内容的大小，并且是前往下一题
			elif current_order>=fill_content.size() and  is_plus:
				#若该题型是最后一个，则return
				if type_index==question_order.size()-1:
					return 0
				#若该题型不是最后一个题型则跳转到下一题型
				to_certain_question(question_order[type_index+1])
				return 1
	return 333
##跳转到任意场景的任意题目
func to_certain_question(type:String,order:int=1):
	#匹配题型
	match type:
		"单选题":
			#加载目标场景
			var target:PackedScene=load("res://scenes/single_choice/single_choice.tscn")
			#实例化目标场景
			var target_ins=target.instantiate()
			#设置目标场景的题目
			target_ins.current_order=order
			#卸载当前场景
			get_tree().root.get_child(1).queue_free()
			#加载目标场景
			get_tree().root.add_child.call_deferred(target_ins)
		"多选题":
			var target:PackedScene=load("res://scenes/multiple_response/multiple_response.tscn")
			var target_ins=target.instantiate()
			target_ins.current_order=order
			get_tree().root.get_child(1).queue_free()
			get_tree().root.add_child.call_deferred(target_ins)
		"简答题":
			var target:PackedScene=load("res://scenes/short_response/short_response.tscn")
			var target_ins=target.instantiate()
			target_ins.current_order=order
			get_tree().root.get_child(1).queue_free()
			get_tree().root.add_child.call_deferred(target_ins)
		"判断题":
			var target:PackedScene=load("res://scenes/true_or_false/true_or_false.tscn")
			var target_ins=target.instantiate()
			target_ins.current_order=order
			get_tree().root.get_child(1).queue_free()
			get_tree().root.add_child.call_deferred(target_ins)
		"填空题":
			var target:PackedScene=load("res://scenes/fill_in/fill_in.tscn")
			var target_ins=target.instantiate()
			target_ins.current_order=order
			get_tree().root.get_child(1).queue_free()
			get_tree().root.add_child.call_deferred(target_ins)
