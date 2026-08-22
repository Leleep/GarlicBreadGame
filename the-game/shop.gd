extends Node

@export var InHandTextures: Array[Texture2D]
@onready var wooshSound := $wooshSound
@onready var amount = $amount
var money := 0

func _ready() -> void:
	amount.label_settings = LabelSettings.new()
	amount.label_settings.font = load("res://Assets/font/Bungee-Regular.ttf")
	amount.z_index = 3
	amount.label_settings.font_color = "#3BB143"
	amount.label_settings.font_size = 80
	amount.label_settings.outline_color = "#000"
	amount.label_settings.outline_size = 3
	amount.text = "₹0"
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


func _on_menu_button_pressed() -> void:
	SceneLoader.load_scene("res://main_menu.tscn")


func _on_customer_success() -> void:
	pass # Replace with function body.

func inc_amount(val: int):
	amount.text = "₹"+str(val)
	var tween = get_tree().create_tween()
	
	tween.tween_property(
		amount, "scale", Vector2(1.2, 1.2), 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		amount, "scale", Vector2(1.0, 1.0), 0.25
	).set_ease(Tween.EASE_IN)
