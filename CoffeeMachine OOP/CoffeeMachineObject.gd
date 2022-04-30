extends Control

class_name CoffeeMachine

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


func _init(water:int, milk:int, coffee:int):
	Ingredients['Water'] = water
	Ingredients['Milk'] = milk
	Ingredients['Coffee'] = coffee


func check_stock(drink: String):
	for i in DrinkRecipes[drink]:
		if DrinkRecipes[drink][i] > Ingredients[i]:
			return false
		else:
			return true


func make_drink(drink: String):
	for i in DrinkRecipes[drink]:
		Ingredients[i] -= DrinkRecipes[drink][i]





