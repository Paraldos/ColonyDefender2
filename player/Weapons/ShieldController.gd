extends Node2D

#################################################
var aktive = false
var MEGASHIELD = preload("res://player/Weapons/MegaShield.tscn")

#################################################
func _ready():
# warning-ignore:return_value_discarded
	MySignals.connect("megashield_off", self, "_on_megashield_off")

func _on_megashield_off():
	aktive = false

#################################################
func _megashield():
	if Utils.player.energy <= 0: return
	if Utils.player.mega_shield == 0: return
	if aktive: return
	###
	if Input.is_action_just_pressed("ui_megashield"):
		aktive = true
		MySignals.emit_signal("megashield_on")
		Utils.player.energy -= 1
		MySignals.emit_signal("energy_update")
		###
		var new = MEGASHIELD.instance()
		add_child(new)
