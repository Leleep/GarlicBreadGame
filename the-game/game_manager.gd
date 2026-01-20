extends Node

var selected_dish_id: String = ""
var correct_dish_id: String = "Correct_dish"  # for now, hardcoded

func select_dish(dish_id: String):
	selected_dish_id = dish_id
	print("Selected dish:", dish_id)

func is_correct_dish_selected() -> bool:
	return selected_dish_id == correct_dish_id

func reset_selection():
	selected_dish_id = ""
