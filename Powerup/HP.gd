extends PowerUp


func _pickup():
	Utils.player.hp += 20
	Utils.player.hp = clamp(Utils.player.hp, 0, Utils._get_hp_max())
	MySignals.emit_signal("hp_update")
