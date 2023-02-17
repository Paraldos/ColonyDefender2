extends PowerUp

func _ready():
	_explosive_movement()

func _explosive_movement(speed = 2):
	move_vector.x = Utils.rng.randf_range(-speed, speed)
	move_vector.y = Utils.rng.randf_range(-speed, speed)

func _pickup():
	Utils.player.credits += 50
	Utils.missionStats.credits.player += 50
	MySignals.emit_signal("credits_update")

