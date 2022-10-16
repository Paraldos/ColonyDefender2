extends Label

func _ready():
	# warning-ignore:return_value_discarded
	MySignals.connect("credits_update", self, "_on_credits_update")
	_on_credits_update()

func _on_credits_update():
	text = "Credits: %s" % [Utils.player.credits]


