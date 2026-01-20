extends TextureButton

var speed = 300
var screen_size
var show_once: bool = true

func _ready():
	$bubble1.hide()
	screen_size = get_viewport_rect().size
	position = Vector2(-200, 191) #Size of texture button is 200, 382 (Set the postion to x/2, y/2)

func _process(_delta: float):
	if(position == Vector2(screen_size.x/2-200, position.y) and show_once):
		$bubble1.show()
		show_once=false

func come():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(screen_size.x/2-200, position.y), 4)


func go():
	$bubble1.hide()
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(screen_size.x, position.y), 4)
