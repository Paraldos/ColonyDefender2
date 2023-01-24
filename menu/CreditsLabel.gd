extends Label

#################################################
func _ready():
	MySignals.connect("credits_update", self, "_on_credits_update")
	_on_credits_update()

#################################################
func _on_credits_update():
	text = "Credits: %s" % [Utils.player.credits]
