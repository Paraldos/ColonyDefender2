extends HBoxContainer

########################################################################
onready var under = $Bar/Under
onready var over = $Bar/Over
onready var label = $Label

########################################################################
func _ready():
	# warning-ignore:return_value_discarded
	MySignals.connect("hp_update", self, "_on_hp_update")
	_on_hp_update()

func _on_hp_update():
	_update_label(Utils.player.hp, Utils.player.hp_max)
	_update_max(Utils.player.hp_max)
	_update_value(float(Utils.player.hp))

func _update_label(newValue, newMaxValue):
	label.text = String(newValue) + "/" + String(newMaxValue)

func _update_max(value):
	over.max_value = value
	under.max_value = value

func _update_value(newValue):
	over.value = newValue
	var tween = create_tween()
	tween.tween_property(under, "value", newValue,  0.5)
