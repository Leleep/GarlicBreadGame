extends Node

@export var InHandTextures: Array[Texture2D]
@onready var wooshSound := $wooshSound

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
	wooshSound.play()


func forward_to_tava(change):
	$pan/TavaManager.updateSprites(change)

func _on_texture_button_mouse_exited() -> void:
	$InHand.visible=false
