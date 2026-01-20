extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
signal pattern_pressed
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
					pattern_pressed.emit()
				_:
					buttonState = 0

	#print("Button State : ", buttonState)
	pass


func _on_button_pressed() -> void:
	buttonPressed = 1
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	buttonPressed = 2
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	buttonPressed = 3
	pass # Replace with function body.


func _on_pattern_pressed() -> void:
	print("Pattern Completed!")
	pass # Replace with function body.
