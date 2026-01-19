extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var buttonState = 0
var buttonPressed = -1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match buttonState:
		0:
			match buttonPressed:
				1:
					buttonState = 1
				_:
					pass;
		1:
			match buttonPressed:
				2:
					buttonState = 2
				1:
					buttonState = 1
				_:
					buttonState = 0
		2:
			match buttonPressed:
				3:
					buttonState = 3
				2:
					buttonState = 2
				_:
					buttonState = 0
		3:
			match buttonPressed:
				3:
					buttonState = 3
				_:
					buttonState = 0
	print("Button State : ", buttonState)
	pass


func _on_button_pressed() -> void:
	print("Button1 Pressed")
	buttonPressed = 1
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	print("Button 2 pressed")
	buttonPressed = 2
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	print("Button 3 pressed")
	buttonPressed = 3
	pass # Replace with function body.
