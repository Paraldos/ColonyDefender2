extends "res://powerup/_Powerup.gd"

func _pickup():
	Utils.player.energy += 1
	Utils.player.energy = clamp(Utils.player.energy, 0, Utils.player.energy_max)
	MySignals.emit_signal("energy_update")
