extends TextureButton

@export var bookTexture : Array[Texture2D]
@onready var bookInst = $Book
var pageNumberOpened := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bookInst.texture = bookTexture[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_pressed() -> void:
	if $Book.visible:
		$Book.visible = false
	else :
		$Book.visible = true

func flip_pages(pageFlipBy : int):
	pageNumberOpened += pageFlipBy
	if (pageNumberOpened < 0) : pageNumberOpened = 0
	if (pageNumberOpened > 2) : pageNumberOpened = 2
	$Book.texture = bookTexture[pageNumberOpened]

func _on_prev_page_button_pressed() -> void:
	flip_pages(-1)


func _on_next_page_button_pressed() -> void:
	flip_pages(1)
