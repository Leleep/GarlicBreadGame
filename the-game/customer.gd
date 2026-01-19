extends Area2D

var speed = 300
var screen_size

func disappears():
	$CustomerSprite.hide()
func appears():
	$CustomerSprite.show()

func _ready():
	$Bubble.hide()
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.RIGHT*speed
	if(position.x<screen_size.x/2):
		position += velocity*delta
	if(position.x>=screen_size.x/2):
		$Bubble.show()
