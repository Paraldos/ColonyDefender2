extends "res://menu/Menu.gd"

onready var creditsLabel = $"%CreditsLabel"
onready var audioCounter = $"%AudioCounter"
onready var timerCounter = $"%TimerCounter"
var credits_counter = 0

#################################################
func _ready():
	_count_credits()

#################################################
func _count_credits():
	yield(get_tree().create_timer(0.5), "timeout")
	timerCounter.start()

func _on_TimerCounter_timeout():
	if _update_credits_counter() == 0: return
	###
	audioCounter.play()
	credits_counter += _update_credits_counter()
	creditsLabel.text = "Credits: %s" % credits_counter
	### restart counter
	timerCounter.start()

func _update_credits_counter():
	var rest = Utils.player.credits - credits_counter
	if rest == 0: return 0
	if rest <= 10: return 1
	if rest <= 100: return 10
	if rest <= 1000: return 100
	return 1000

#################################################
func _on_BtnNextStage_pressed():
	Utils._next_stage()
	SceneTransition.change_scene("res://world/World.tscn")

func _on_BtnShop_pressed():
	Utils._open_shop()


