extends Button

signal new_planet_requested()

func _pressed():
	new_planet_requested.emit()
