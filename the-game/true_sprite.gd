extends Sprite2D

func _input(event: InputEvent):
	if(event is InputEventMouseButton and event.pressed and event.button_index==MOUSE_BUTTON_LEFT
		 and is_pixel_opaque(get_local_mouse_position())):
		print("Clickeddd")
