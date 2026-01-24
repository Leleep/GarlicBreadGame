extends Node

@export var InHandTextures: Array[Texture2D]

func _ready() -> void:
	$InHandItemManager.inHandItemChanged.connect(change_texture_hand)
	$InHandItemManager.tikkiStatus.connect(forward_to_tava)

func change_texture_hand(state):
	if state!=GlobalEnums.State.Garbage:
		print("inhand sprite", state)
		$InHand/Garbage.visible = false
		$InHand/Item.texture=InHandTextures[state]
	else:
		$InHand/Garbage.visible = true


func _on_texture_button_mouse_entered() -> void:
	$InHand.visible=true


func forward_to_tava(change):
	$pan/TavaManager.updateSprites(change)

func _on_texture_button_mouse_exited() -> void:
	$InHand.visible=false


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://loading_screen.tscn")
