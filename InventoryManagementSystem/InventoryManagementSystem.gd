extends Control


var data: Dictionary
var path: String
var item := preload("res://InventoryManagementSystem/item.tscn")

onready var table := get_node("Table/VBoxContainer")


func _ready():
	connect_signals()



func connect_signals():
	get_node("RefreshButton").connect('pressed', self, '_on_Refresh_pressed')
	get_node("LoadButton").connect('pressed', self, '_on_Load_pressed')
	get_node("FileDialog").connect('file_selected', self, '_on_file_selected')
	get_node("FileDialog").connect('confirmed', self, '_on_confirmed')


func get_data(path):
	var maindata = {}
	var f = File.new()
	if f.file_exists(path):
		f.open(path, f.READ)
		while !f.eof_reached():
			var data_set = Array(f.get_csv_line())
			maindata[maindata.size()] = data_set
		f.close()

		maindata.erase(maindata.size()-1)
	
	return maindata


func add_items(spread_data):
	for i in spread_data:
		if !i == 0:
			var item_inst = item.instance()
			item_inst.name = str(i)
			item_inst.get_node("Code").text = spread_data[i][0]
			item_inst.get_node("Description").text = spread_data[i][1]
			item_inst.get_node("Category").text = spread_data[i][2]
			item_inst.get_node("Brand").text = spread_data[i][3]
			item_inst.get_node("Stock").text = spread_data[i][4]
			item_inst.get_node("Hold").text = spread_data[i][5]
			table.add_child(item_inst)


func _on_Refresh_pressed():
	data = get_data(path)
	clearitems()
	add_items(data)


func clearitems():
	for c in table.get_children():
		c.queue_free()


func _on_Load_pressed():
	get_node("FileDialog").current_dir = OS.get_system_dir(2)
	get_node("FileDialog").show()


func _on_file_selected(filepath):
	path = filepath
	data = get_data(path)
	clearitems()
	add_items(data)


func _on_confirmed():
	path = get_node("FileDialog").current_path
	data = get_data(path)
	clearitems()
	add_items(data)
