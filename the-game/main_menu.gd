extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$howto.visible = false
	$closeButton.visible = false
	$thela_rot.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	$thela_rot.play()
	$howto.visible = false
	$closeButton.visible = false
	
	# enable button
	var buttons = $VBoxContainer.get_children()
	for button in buttons:
		button.disabled = false


func _on_how_to_pressed() -> void:
	$thela_rot.pause()
	$closeButton.visible = true
	$howto.visible=true
	
	# disable buttons
	var buttons = $VBoxContainer.get_children()
	for button in buttons:
		button.disabled = true

func _on_start_pressed() -> void:
	SceneLoader.load_scene("res://main.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
