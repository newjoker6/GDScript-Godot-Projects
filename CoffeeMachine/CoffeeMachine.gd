extends Control


var Ingredients := {
	'Water': 300,
	'Milk': 200,
	'Coffee': 100
}

var DrinkRecipes := {
	'espresso': {
		'Water': 50,
		'Coffee': 18
	},
	'latte': {
		'Water': 200,
		'Coffee': 24,
		'Milk': 150
	},
	'cappuccino': {
		'Water': 250,
		'Coffee': 24,
		'Milk': 100
	}
}


func _ready():
	create_ui()
	connect_signals()


func create_ui():
	var label = Label.new()
	label.rect_size = Vector2(360, 14)
	label.rect_position = Vector2(334, 288)
	label.align = Label.ALIGN_CENTER
	label.text = "Select a drink"
	label.name = "MessageLabel"
	
	var button1 = Button.new()
	button1.rect_position = Vector2(350, 333)
	button1.text = "espresso"
	button1.name = "EspressoButton"
	
	var button2 = Button.new()
	button2.rect_position = Vector2(500, 333)
	button2.text = "latte"
	button2.name = "LatteButton"
	
	var button3 = Button.new()
	button3.rect_position = Vector2(600, 333)
	button3.text = "cappuccino"
	button3.name = "CappuccinoButton"
	
	self.add_child(label)
	self.add_child(button1)
	self.add_child(button2)
	self.add_child(button3)


func connect_signals():
	self.get_node("./EspressoButton").connect("pressed", self, "_on_espresso_pressed")
	self.get_node("./LatteButton").connect("pressed", self, "_on_latte_pressed")
	self.get_node("./CappuccinoButton").connect("pressed", self, "_on_cappuccino_pressed")


func _on_espresso_pressed():
	if check_stock("espresso"):
		make_drink("espresso")
		self.get_node("./MessageLabel").text = "Here is your espresso drink."


func _on_latte_pressed():
	if check_stock("latte"):
		make_drink("latte")
		self.get_node("./MessageLabel").text = "Here is your latte drink."


func _on_cappuccino_pressed():
	if check_stock("cappuccino"):
		make_drink("cappuccino")
		self.get_node("./MessageLabel").text = "Here is your cappuccino drink."


func check_stock(drink: String):
	for i in DrinkRecipes[drink]:
		if DrinkRecipes[drink][i] > Ingredients[i]:
			self.get_node("./MessageLabel").text = "Not enough ingredients."
			return false
		else:
			return true


func make_drink(drink: String):
	for i in DrinkRecipes[drink]:
		Ingredients[i] -= DrinkRecipes[drink][i]





