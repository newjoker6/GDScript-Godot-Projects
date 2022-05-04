extends Control


var data: Dictionary

var chars := ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
"!", "@", "#", "$", "%", "^", "&", "*", ":", ":", "?"]


func _ready():
	connect_signals()
	load_data()


func connect_signals():
	get_node("AddButton").connect("pressed", self, "_on_add_pressed")
	get_node("ShowButton").connect("pressed", self, "_on_show_pressed")
	get_node("SearchButton").connect("pressed", self, "_on_search_pressed")
	get_node("GenerateButton").connect("pressed", self, "_on_generate_pressed")


func _on_add_pressed():
	OS.set_clipboard(get_node("PasswordLine").text)
	get_node("NoteLabel").visible = true
	add_entry()
	save_data()


func _on_show_pressed():
	get_node("PasswordLine").secret = not get_node("PasswordLine").secret


func _on_search_pressed():
	var target = get_node("WebsiteLine").text.to_lower()
	get_node("PasswordLine").secret = true
	get_node("PasswordLine").text = data[target]["password"]
	get_node("UserLIne").text = data[target]["email"]
	OS.set_clipboard(get_node("PasswordLine").text)


func _on_generate_pressed():
	randomize()
	var password:String
	while password.length() < 10:
			var select = randi() % chars.size()
			var UL = randi() % 2 +1
			if UL == 1:
				password += chars[select].to_upper()
			elif UL == 2:
				password += chars[select].to_lower()
	get_node("PasswordLine").text = password


func save_data():
	var f = File.new()
	var path = "user://data.json"
	f.open(path, f.WRITE)
	f.store_line(to_json(data))
	f.close()


func load_data():
	var f= File.new()
	var path = "user://data.json"
	if f.file_exists(path):
		f.open(path, f.READ)
		data = parse_json(f.get_as_text())
		f.close()
	else:
		return


func add_entry():
	var target = get_node("WebsiteLine").text.to_lower()
	data[target] = {}
	data[target]["password"] = get_node("PasswordLine").text
	data[target]["email"] = get_node("UserLIne").text
