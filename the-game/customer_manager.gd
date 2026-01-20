extends Node

var cust_pos: Array = [1]
@onready var customer1 = $Customer1
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(cust_pos.size()!=0):
		spawn_customer()

func spawn_customer():
	customer1.come()
	cust_pos.clear()

func _on_customer_1_pressed() -> void:
	customer1.go()
