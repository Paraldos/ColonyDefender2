extends Node2D

func _megabomb():
	if Utils.player.energy <= 0: return
	if Input.is_action_just_pressed("ui_megabomb"):
		Utils.player.energy -= 1
		MySignals.emit_signal("energy_update")
		###
		var new = MyPreload.MEGABOMB.instance()
		new.global_position = global_position
		get_tree().current_scene.add_child(new)
