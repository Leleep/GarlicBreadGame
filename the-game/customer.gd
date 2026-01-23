extends TextureButton

signal left_slot(slot_idx, curr_dish)
var curr_dish
var speed = 300
var screen_size
var final_pos
var slot_idx
var active := false
var inHandItem
var hasDona: bool = false

@export var normal_textures: Array[Texture2D]
@export var hover_textures: Array[Texture2D]
@export var click_masks: Array[BitMap]
@export var dish_textures: Array[Texture2D]

func _ready():
	apply_skin()
	apply_dish()
	$bubble1.hide()
	screen_size = get_viewport_rect().size
	position = Vector2(-400, 191) #Size of texture button is 200, 382 (Set the postion to x/2, y/2)
	disabled = true
	pressed.connect(_on_pressed)

func apply_skin():
	var i = randi()%4
	texture_normal = normal_textures[i]
	texture_hover = hover_textures[i]
	texture_click_mask = click_masks[i]

func apply_dish():
	var i = randi()%3
	#var i = 0
	$bubble1/Dish.texture = dish_textures[i]
	if i==0:
		curr_dish=GlobalEnums.State.TikkiComplete
	elif i==1:
		curr_dish=GlobalEnums.State.GPP
	elif i==2:
		curr_dish=GlobalEnums.State.RPP

func come(pos):
	var tween = create_tween()
	slot_idx=pos
	var positions: Array = [Vector2(screen_size.x/4-200, position.y), Vector2(screen_size.x/2-200, position.y), Vector2(screen_size.x*0.75-200, position.y)]
	final_pos = positions[pos]
	tween.tween_property(self, "position", positions[pos], (positions[pos].x - position.x)/speed)
	await get_tree().create_timer((positions[pos].x - position.x)/speed-0.01).timeout
	$bubble1.show()
	disabled = false
	active = true

#func itemState(state):
	#inHandItem = state
	#print("in Customer.gd: ", inHandItem)

func _on_pressed() -> void:
	left_slot.emit(slot_idx, curr_dish)

func go():
	$Don.visible=false
	$bubble1.hide()
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(screen_size.x, position.y), (screen_size.x-final_pos.x)/speed)
	#left_slot.emit(slot_idx)
	await get_tree().create_timer((screen_size.x-final_pos.x)/speed).timeout
	queue_free()
