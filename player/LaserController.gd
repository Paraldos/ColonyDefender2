extends Node2D

#################################################
var aktive = false

#################################################
func _ready():
# warning-ignore:return_value_discarded
	MySignals.connect("megalaser_off", self, "_on_megalaser_off")

func _on_megalaser_off():
	aktive = false

#################################################
func _megalaser():
	if Utils.player.energy <= 0: return
	if aktive: return
	###
	if Input.is_action_just_pressed("ui_megalaser"):
		aktive = true
		Utils.player.energy -= 1
		MySignals.emit_signal("energy_update")
		###
		var new = preload("res://player/Megalaser.tscn").instance()
		new.position = Vector2(0, -15)
		add_child(new)
