extends Control


var bid_data := {}


# Called when the node enters the scene tree for the first time.
func _ready():
	create_ui()
	connect_signals()


func create_ui():
	var label = Label.new()
	label.rect_size = Vector2(360, 14)
	label.rect_position = Vector2(334, 388)
	label.align = Label.ALIGN_CENTER
	label.text = ""
	label.name = "WinnerLabel"
	
	var input1 = LineEdit.new()
	input1.rect_size = Vector2(374, 24)
	input1.rect_position = Vector2(325, 248)
	input1.placeholder_text = "Name"
	input1.name = "BidName"
	
	var input2 = LineEdit.new()
	input2.rect_size = Vector2(374, 24)
	input2.rect_position = Vector2(325, 288)
	input2.placeholder_text = "Bid Amount"
	input2.name = "BidAmount"
	
	var button1 = Button.new()
	button1.rect_position = Vector2(595, 333)
	button1.text = "Bid"
	button1.name = "BidButton"
	
	var button2 = Button.new()
	button2.rect_position = Vector2(672, 333)
	button2.text = "Draw"
	button2.name = "DrawButton"
	
	self.add_child(label)
	self.add_child(input1)
	self.add_child(input2)
	self.add_child(button1)
	self.add_child(button2)


func connect_signals():
	self.get_node("./BidButton").connect("pressed", self, "_on_bid_pressed")
	self.get_node("./DrawButton").connect("pressed", self, "_on_draw_pressed")
	
	self.get_node("./BidName").connect("text_entered", self, "_on_text_entered")
	self.get_node("./BidAmount").connect("text_entered", self, "_on_text_entered")


func _on_bid_pressed():
	place_bid(self.get_node("./BidName").text, self.get_node("./BidAmount").text)


func _on_text_entered(new_text: String):
	place_bid(self.get_node("./BidName").text, self.get_node("./BidAmount").text)


func _on_draw_pressed():
	var highest_bid: float
	var winner: String
	
	for bidder in bid_data.keys():
		if highest_bid < float(bid_data[bidder]):
			highest_bid = float(bid_data[bidder])
			winner = bidder
	self.get_node("./WinnerLabel").text = "The winner is %s with a bid of %s" %[winner, highest_bid]


func place_bid(username:String, userbid:String):
	if !username == "" and !userbid == "":
			bid_data[username] = userbid
			self.get_node("./BidName").clear()
			self.get_node("./BidAmount").clear()

