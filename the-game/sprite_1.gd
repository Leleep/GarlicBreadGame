extends Sprite2D

func _input(event: InputEvent) -> void:
	if event is InputEvent and event.is_pressed() == true:
		if(get_rect()).has_point(to_local(event.position)):
			print("clicked")
