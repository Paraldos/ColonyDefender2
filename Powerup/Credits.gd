extends PowerUp

func _pickup():
	Utils.player.credits += 50
	MySignals.emit_signal("credits_update")

