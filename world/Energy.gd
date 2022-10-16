extends HBoxContainer

########################################################################
onready var under = $Bar/Under
onready var over = $Bar/Over
onready var label = $EnergyLabel

########################################################################
func _ready():
	# warning-ignore:return_value_discarded
	MySignals.connect("energy_update", self, "_on_energy_update")
	_on_energy_update()

func _on_energy_update():
	_update_label(Utils.player.energy, Utils.player.energy_max)
	_update_max(Utils.player.energy_max) 
	_update_value(float(Utils.player.energy))

func _update_label(newValue, newMaxValue):
	label.text = String(newValue) + "/" + String(newMaxValue)

func _update_max(value):
	over.max_value = value
	under.max_value = value

func _update_value(newValue):
	over.value = newValue
	var tween = create_tween()
	tween.tween_property(under, "value", newValue,  0.5)


