extends Control

var cards := [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
var Dealer_Hand := []
var Player_Hand := []
var Dealer_Total:int
var Player_Total:int


func _ready():
	connect_signals()
	randomize()
	deal_cards()
	check_player()


func connect_signals():
	get_node("HitButton").connect("pressed", self, "_on_HitButton_pressed")
	get_node("StandButton").connect("pressed", self, "_on_StandButton_pressed")


func deal_cards():
	hit(Player_Hand)
	hit(Dealer_Hand)
	hit(Player_Hand)
	Dealer_Hand.append("?")


func total_user(hand: Array):
	var total:= 0
	for card in hand:
		total += card
	return total


func hit(hand: Array):
	hand.append(cards[randi() %cards.size()])


func _on_HitButton_pressed():
	hit(Player_Hand)
	check_player()


func _on_StandButton_pressed():
	dealer_draw()
	declare_winner()


func check_player():
	Player_Total = total_user(Player_Hand)
	get_node("PlayerLabel").text = 'Total: %s' %Player_Total
	if Player_Total > 21:
		get_node("EndScreen").visible = true
		get_node("EndScreen/Result").text = "You Lose"
		
		get_node("HitButton").disabled = true
		get_node("StandButton").disabled = true


func dealer_draw():
	Dealer_Hand.erase("?")
	hit(Dealer_Hand)
	Dealer_Total = total_user(Dealer_Hand)
	while Dealer_Total < 17:
		hit(Dealer_Hand)
		Dealer_Total = total_user(Dealer_Hand)
	get_node("DealerLabel").text = 'Total: %s' %Dealer_Total


func declare_winner():
	get_node("EndScreen").visible = true
	get_node("HitButton").disabled = true
	get_node("StandButton").disabled = true

	if Player_Total > Dealer_Total or Dealer_Total > 21:
		get_node("EndScreen/Result").text = "You Win"
		
	elif Dealer_Total > Player_Total:
		get_node("EndScreen/Result").text = "You Lose"
		
	elif Player_Total == Dealer_Total:
		get_node("EndScreen/Result").text = "Draw"

