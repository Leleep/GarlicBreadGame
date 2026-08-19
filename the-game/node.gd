extends Node
var currentState : GlobalEnums.State = GlobalEnums.State.Empty
@onready var click := $clickSound
@onready var dump := $dumpSound
signal inHandItemChanged(state)
signal tikkiStatus(change)

func updateState(item : GlobalEnums.Item):
	match currentState:
		GlobalEnums.State.Empty:
			match item:
				GlobalEnums.Item.Puri:
					currentState = GlobalEnums.State.Puri
				GlobalEnums.Item.Dona:
					currentState = GlobalEnums.State.Dona
				GlobalEnums.Item.Tikki:
					currentState = GlobalEnums.State.Tikki
				_:
					currentState = GlobalEnums.State.Garbage
			pass
		GlobalEnums.State.Puri:
			match item:
				GlobalEnums.Item.Aloo:
					currentState = GlobalEnums.State.AlooPuri
				GlobalEnums.Item.Puri:
					currentState = GlobalEnums.State.Empty
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.AlooPuri:
			match item:
				GlobalEnums.Item.GreenPaani:
					currentState  = GlobalEnums.State.GreenAlooPuri
				GlobalEnums.Item.RedPaani:
					currentState = GlobalEnums.State.RedAlooPuri
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.GreenAlooPuri:
			match item:
				GlobalEnums.Item.Masala:
					currentState = GlobalEnums.State.GPP
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.RedAlooPuri:
			match item:
				GlobalEnums.Item.Masala:
					currentState = GlobalEnums.State.RPP
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.Dona:
			match item:
				GlobalEnums.Item.FriedTikki:
					currentState = GlobalEnums.State.TikkiDona
				GlobalEnums.Item.Dona:
					currentState = GlobalEnums.State.Empty
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.TikkiDona:
			match item:
				GlobalEnums.Item.Dahi:
					currentState = GlobalEnums.State.DahiTikki
				GlobalEnums.Item.Chutney:
					currentState = GlobalEnums.State.ChutneyTikki
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.DahiTikki:
			match item:
				GlobalEnums.Item.Chutney:
					currentState = GlobalEnums.State.ChutneyDahiTikki
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.ChutneyTikki:
			match item:
				GlobalEnums.Item.Dahi:
					currentState = GlobalEnums.State.ChutneyDahiTikki
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.ChutneyDahiTikki:
			match item:
				GlobalEnums.Item.Aloo:
					currentState = GlobalEnums.State.AlooTikki
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.AlooTikki:
			match item:
				GlobalEnums.Item.Masala:
					currentState = GlobalEnums.State.TikkiComplete
				_:
					currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.GPP:
			currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.RPP:
			currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.TikkiComplete:
			currentState = GlobalEnums.State.Garbage
		GlobalEnums.State.Tikki:
			match item:
				GlobalEnums.Item.Tikki:
					currentState = GlobalEnums.State.Empty
				_:
					currentState = GlobalEnums.State.Garbage
		_:
			print("Invalid state encountered")
	print("State changed to", currentState)
	inHandItemChanged.emit(currentState)

func sound():
	if currentState == GlobalEnums.State.Garbage:
		$turdSound.play()
	else: click.play()

func succeeded():
	currentState=GlobalEnums.State.Empty
	inHandItemChanged.emit(currentState)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

var TikkiOnTava : int = 0

func _on_pan_pressed() -> void:
	if currentState == GlobalEnums.State.Tikki and TikkiOnTava<4:
		$fryingSound.play()
		TikkiOnTava += 1
		tikkiStatus.emit(0)
		currentState = GlobalEnums.State.Empty
		inHandItemChanged.emit(currentState)
	elif currentState == GlobalEnums.State.Dona and TikkiOnTava > 0:
		updateState(GlobalEnums.Item.FriedTikki)
		TikkiOnTava -= 1
		tikkiStatus.emit(1)
		sound()
	else :
		print("Tava Not Applicable")
		$hurtSound.play()
	


func _on_plates_pressed() -> void:
	updateState(GlobalEnums.Item.Dona)
	sound()


func _on_red_paani_pressed() -> void:
	updateState(GlobalEnums.Item.RedPaani)
	sound()


func _on_green_pani_pressed() -> void:
	updateState(GlobalEnums.Item.GreenPaani)
	sound()


func _on_puriyaan_pressed() -> void:
	updateState(GlobalEnums.Item.Puri)
	sound()


func _on_masala_pressed() -> void:
	updateState(GlobalEnums.Item.Masala)
	sound()


func _on_kachchi_tikkiyaan_pressed() -> void:
	updateState(GlobalEnums.Item.Tikki)
	sound()


func _on_aloo_matar_pressed() -> void:
	updateState(GlobalEnums.Item.Aloo)
	sound()


func _on_dahi_pressed() -> void:
	updateState(GlobalEnums.Item.Dahi)
	sound()


func _on_chutney_pressed() -> void:
	updateState(GlobalEnums.Item.Chutney)
	sound()

# Korewa Comment desu
func _on_dustbin_pressed() -> void:
	if currentState == GlobalEnums.State.Empty : sound()
	else : dump.play()
	currentState = GlobalEnums.State.Empty
	print("Dustbin used. Current GlobalEnums.State is ", currentState)
	inHandItemChanged.emit(currentState)
