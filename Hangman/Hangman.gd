extends Control


var word_list := ["advark", "baboon", "camel", "shark", "banana", "Holy butt fucking shit"]
var lives := 6
var guessed_letters := []
var chosen_word: String
var display:String

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()
	update_lives()
	randomize()
	select_word()
	


func connect_signals():
	get_node("GuessBox").connect("text_entered", self, '_on_guess')
	get_node("PlayAgainButton").connect('pressed', self, '_on_button_pressed')


func _on_guess(guess):
	get_node("GuessBox").clear()
	if !guess.length() == 1:
		return
		
	if guess.to_upper() in guessed_letters:
		return
		
	if !guess.to_upper() in chosen_word.to_upper():
		guessed_letters.append(guess.to_upper())
		return
	
	for i in range(chosen_word.length()):
		var c = chosen_word[i]
		if c.to_upper() == guess.to_upper():
			display[i] = guess.to_upper()
	
	guessed_letters.append(guess.to_upper())
	get_node("Word").text = display


func check_win():
	if !'_' in display:
		get_node("Word").text = 'YOU WIN! The word was %s' %chosen_word
		get_node("PlayAgainButton").visible = true


func remove_life():
	lives -= 1
	update_lives()
	if lives <= 0:
		get_node("Word").text = 'YOU LOSE! The word was %s' %chosen_word
		get_node("PlayAgainButton").visible = true


func update_lives():
	get_node("LivesLabel").text = "Lives: %s" %lives


func _on_button_pressed():
	get_tree().reload_current_scene()


func select_word():
	chosen_word = word_list[randi()%word_list.size()]

	for i in range(chosen_word.length()):
		if chosen_word[i] == " ":
			display += ' '
		elif chosen_word[i] == "-":
			display += '-'
		else:
			display += '_'
	get_node("Word").text = display
