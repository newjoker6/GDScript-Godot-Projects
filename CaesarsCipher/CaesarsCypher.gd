extends Control


var alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
			'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
			'u', 'v', 'w', 'x', 'y', 'z']


func _ready():
	create_ui()
	connect_signals()


func create_ui():
	var label = Label.new()
	label.rect_size = Vector2(395, 24)
	label.rect_position = Vector2(314, 252)
	label.text = "Enter text to encrypt."
	label.name = "Label"
	
	var input = LineEdit.new()
	input.rect_size = Vector2(395, 24)
	input.rect_position = Vector2(314, 288)
	input.name = "InputField"
	
	var button1 = Button.new()
	button1.rect_position = Vector2(314, 325)
	button1.text = "encrypt"
	button1.name = "EncryptButton"
	
	var button2 = Button.new()
	button2.rect_position = Vector2(650, 325)
	button2.text = "decrypt"
	button2.name = "DecryptButton"
	
	self.add_child(label)
	self.add_child(input)
	self.add_child(button1)
	self.add_child(button2)


func connect_signals():
	self.get_node("./EncryptButton").connect("pressed", self, "_on_encrypt_pressed")
	self.get_node("./DecryptButton").connect("pressed", self, "_on_decrypt_pressed")


func _on_encrypt_pressed():
	self.get_node("./InputField").text = encryption(self.get_node("./InputField").text, 2)


func _on_decrypt_pressed():
	self.get_node("./InputField").text = decryption(self.get_node("./InputField").text, 2)


func encryption(text:String, shift_amount:int):
	var encrypted_msg: String
	for l in text:
		if l in alphabet:
			var i = alphabet.find(l)
			i += shift_amount
			if i >= alphabet.size():
				i -= alphabet.size()
			encrypted_msg += alphabet[i]
		else:
			encrypted_msg += l
	return encrypted_msg


func decryption(text: String, shift_amount:int):
	var decrypted_msg: String
	for l in text:
		if l in alphabet:
			var i = alphabet.find(l)
			i -= shift_amount
			decrypted_msg += alphabet[i]
			
		else:
			decrypted_msg += l
	return decrypted_msg
