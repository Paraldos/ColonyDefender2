extends Node

var pauseCounter = 0

func _start():
	pauseCounter += 1
	get_tree().paused = true

func _stop():
	pauseCounter -= 1
	if pauseCounter <= 0:
		get_tree().paused = false
