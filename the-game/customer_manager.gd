extends Node

var cust_pos: Array = [0, 0, 0]
var customer_instances: Array = [0,0,0]
var cust_item
signal success
@export var customer_scene: PackedScene

func _ready() -> void:
	spawn_manager()

func spawn_manager():
	while true:
		for i in range(cust_pos.size()):
			if(cust_pos[i]==0):
				spawn_customer_at(i)
			await get_tree().create_timer(4).timeout
		await get_tree().process_frame

func spawn_customer_at(slot_index):
	var customer_inst = customer_scene.instantiate()
	add_child(customer_inst)
	customer_instances[slot_index] = customer_inst
	customer_inst.left_slot.connect(_on_left_slot)
	#customer_inst.itemState(cust_item)
	cust_pos[slot_index] = 1
	customer_inst.come(slot_index)

func itemState_toCustomerChild(state):
	cust_item=state
	print("in customer_manager:", cust_item)
	
#cust_item is given by main function (main.gd), which is the item in hand and cust_dish is given by customer instance when its sprite is pressed
func _on_left_slot(slot_index, cust_dish):
	if(cust_dish!=GlobalEnums.State.TikkiComplete): # This is if customer demands pani puri, so we first have to give dona
		if(customer_instances[slot_index].hasDona):
			if cust_item == cust_dish:
				goSuccess(slot_index)
				$kachingSound.play()
			else:
				print("wrong dish, make correct fool")
				$hurtSound.play()
		else:
			if cust_item==GlobalEnums.State.Dona:
				customer_instances[slot_index].hasDona = true
				customer_instances[slot_index].get_node("Don").visible=true
				success.emit()
			else:
				# Something else insteaed of Dona given to the customer
				$hurtSound.play()
	else: #This is if the customer demands tikki, no need to give dona
		if cust_item == cust_dish:
			goSuccess(slot_index)
			$kachingSound.play()
		else:
			print("wrong dish, make correct fool")
			$hurtSound.play()

func goSuccess(slot_index): #call go and empty the slot.
	success.emit()
	customer_instances[slot_index].hfshow()
	customer_instances[slot_index].go()
	cust_pos[slot_index]=0
