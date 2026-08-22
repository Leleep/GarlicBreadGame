extends Node

@onready var inhandnode = $shop/InHandItemManager
@onready var customer = $Customer
@onready var amount = $shop/amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inhandnode.inHandItemChanged.connect(_on_in_hand)
	customer.success.connect(_on_success)
	amount.text = "₹0"

func _on_in_hand(state):
	customer.itemState_toCustomerChild(state)

func _on_success():
	inhandnode.succeeded()


func _on_customer_success() -> void:
	inhandnode.succeeded()
