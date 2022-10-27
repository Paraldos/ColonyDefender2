extends Label

onready var audioCoin = $AudioCoin
onready var countUpTimer = $CountUpTimer
signal count_up_done()
export var countUp = false
var creditsOnDisplay = 0

#################################################
func _ready():
	# warning-ignore:return_value_discarded
	MySignals.connect("credits_update", self, "_on_credits_update")
	if countUp:
		countUpTimer.start()
	else:
		_on_credits_update()

#################################################
func _on_credits_update():
	text = "Credits: %s" % [Utils.player.credits]

#################################################
func _on_CountUpTimer_timeout():
	audioCoin.play()
	_count_up()

func _count_up():
	creditsOnDisplay += _get_counter()
	text = "Credits: " + String(creditsOnDisplay)
	if creditsOnDisplay >= Utils.player.credits: 
		countUpTimer.stop()
		emit_signal("count_up_done")

func _get_counter():
	if Utils.player.credits - creditsOnDisplay <= 5:
		return 1
	elif Utils.player.credits - creditsOnDisplay <= 10:
		return 5
	elif Utils.player.credits - creditsOnDisplay <= 50:
		return 10
	elif Utils.player.credits - creditsOnDisplay <= 100:
		return 50
	elif Utils.player.credits - creditsOnDisplay <= 1000:
		return 100
	else:
		return 1000

