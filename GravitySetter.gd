extends HScrollBar

signal gravity_setter(val)

func _value_changed(new_value):
	gravity_setter.emit(self.value)
