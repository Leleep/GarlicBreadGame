extends Node

var lastTikki = 0
@onready var tikkiyan: Array = [$tikki, $chikki, $rikki, $nikki]

func _ready() -> void:
	pass # Replace with function body.

func updateSprites(change):
	if change == 0:
		tikkiyan[lastTikki].visible=true
		lastTikki+=1
	else:
		lastTikki-=1
		tikkiyan[lastTikki].visible=false
