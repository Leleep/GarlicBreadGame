extends Node

enum Item {Dona, Puri, GreenPaani, RedPaani, Masala, FriedTikki, Dahi, Chutney, Aloo, Tikki}

# RPP - Red Pani Puri
# GPP - Green Pani Puri
enum State {
	Empty,
	Puri,
	AlooPuri,
	RedAlooPuri,
	GreenAlooPuri,
	RPP,
	GPP,
	Dona,
	TikkiDona,
	DahiTikki,
	ChutneyDahiTikki,
	ChutneyTikki,
	AlooTikki,
	TikkiComplete,
	Garbage,
	Tikki,
	}

var currentState : State = State.Empty

func updateState(item : Item):
	match currentState:
		State.Empty:
			match item:
				Item.Puri:
					currentState = State.Puri
				Item.Dona:
					currentState = State.Dona
				Item.Tikki:
					currentState = State.Tikki
				_:
					currentState = State.Garbage
			pass
		State.Puri:
			match item:
				Item.Aloo:
					currentState = State.AlooPuri
				_:
					currentState = State.Garbage
		State.AlooPuri:
			match item:
				Item.GreenPaani:
					currentState  = State.GreenAlooPuri
				Item.RedPaani:
					currentState = State.RedAlooPuri
				_:
					currentState = State.Garbage
		State.GreenAlooPuri:
			match item:
				Item.Masala:
					currentState = State.GPP
				_:
					currentState = State.Garbage
		State.RedAlooPuri:
			match item:
				Item.Masala:
					currentState = State.RPP
				_:
					currentState = State.Garbage
		State.Dona:
			match item:
				Item.FriedTikki:
					currentState = State.TikkiDona
				_:
					currentState = State.Garbage
		State.TikkiDona:
			match item:
				Item.Dahi:
					currentState = State.DahiTikki
				Item.Chutney:
					currentState = State.ChutneyTikki
				_:
					currentState = State.Garbage
		State.DahiTikki:
			match item:
				Item.Chutney:
					currentState = State.ChutneyDahiTikki
				_:
					currentState = State.Garbage
		State.ChutneyTikki:
			match item:
				Item.Dahi:
					currentState = State.ChutneyDahiTikki
				_:
					currentState = State.Garbage
		State.ChutneyDahiTikki:
			match item:
				Item.Aloo:
					currentState = State.AlooTikki
				_:
					currentState = State.Garbage
		State.AlooTikki:
			match item:
				Item.Masala:
					currentState = State.TikkiComplete
				_:
					currentState = State.Garbage
		State.GPP:
			currentState = State.Garbage
		State.RPP:
			currentState = State.Garbage
		State.TikkiComplete:
			currentState = State.Garbage
		State.Tikki:
			currentState = State.Garbage
		_:
			print("Invalid state encountered")
	print("State changed to", currentState)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pan_pressed() -> void:
	updateState(Item.FriedTikki)
	pass # Replace with function body.


func _on_plates_pressed() -> void:
	updateState(Item.Dona)
	pass # Replace with function body.


func _on_red_paani_pressed() -> void:
	updateState(Item.RedPaani)
	pass # Replace with function body.


func _on_green_pani_pressed() -> void:
	updateState(Item.GreenPaani)
	pass # Replace with function body.


func _on_puriyaan_pressed() -> void:
	updateState(Item.Puri)
	pass # Replace with function body.


func _on_masala_pressed() -> void:
	updateState(Item.Masala)
	pass # Replace with function body.


func _on_kachchi_tikkiyaan_pressed() -> void:
	updateState(Item.Tikki)
	pass # Replace with function body.


func _on_aloo_matar_pressed() -> void:
	updateState(Item.Aloo)
	pass # Replace with function body.


func _on_dahi_pressed() -> void:
	updateState(Item.Dahi)


func _on_chutney_pressed() -> void:
	updateState(Item.Chutney)


func _on_dustbin_pressed() -> void:
	currentState = State.Empty
	print("Dustbin used. Current State is ", currentState)
