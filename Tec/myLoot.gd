extends Node

var powerupCounter = 0
var rng = RandomNumberGenerator.new()
const POWERUPS = [
	preload("res://Powerup/Energy.tscn"),
	preload("res://Powerup/HP.tscn")
]

func _enter_tree():
	rng.randomize()

########################################################################
### spawn coins
func _spawn_coins(pos):
	var new = preload("res://Powerup/Coin.tscn").instance()
	new.global_position = pos
	get_tree().current_scene.add_child(new)

########################################################################
### spawn powerup
func _spawn_powerup(pos):
	if _allow_powerup(): 
		_instance_powerup(pos)

func _allow_powerup():
	powerupCounter += 1
	if powerupCounter >= 10 and rng.randi_range(0, 5) == 0:
		powerupCounter = 0
		return true

func _instance_powerup(pos):
	var new = POWERUPS[randi() % POWERUPS.size()].instance()
	new.global_position = pos
	get_tree().current_scene.add_child(new)

