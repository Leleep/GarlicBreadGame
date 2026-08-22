extends CanvasLayer

# Make sure this matches the exact name of your Sprite2D node!
@onready var sprite = $loading 

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_progress_changed(_new_value: float) -> void:
	pass

func _on_load_finished() -> void:
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_interval(0.2) #to display the loading screen for atleast 1 sec, can change ts
	tween.tween_property(sprite, "scale", Vector2.ZERO, 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	
	tween.tween_callback(finish_transition)

func finish_transition() -> void:
	get_tree().paused = false
	queue_free()
