extends Node

#################################################
var rng = RandomNumberGenerator.new()
var window_width = 480
var window_height = 270
var wave = 0
var newPlayer = {
	credits = 20000,
	hp_max = 50,
	hp = 50,
	hp_level = 0,
	energy_max = 4,
	energy = 4,
	gun_damage = 0,
	megabomb_dmg = 40,
	megalaser_dmg = 20,
	magnet_distance = 100
}
var oldPlayer = {}
var player = {}
var player_pos
var player_node
var pause_posible = true

#################################################
func _get_gun_dmg():
	return 5 + (player.gun_damage *2)

func _get_hp_max():
	return 50 + (player.hp_level * 10)

#################################################
func _enter_tree():
	rng.randomize()

#################################################
func _new_game():
	player = newPlayer.duplicate()
	_next_stage()

func _next_stage():
	oldPlayer = player.duplicate()
	wave = 0
	player.hp = _get_hp_max()
	player.energy = player.energy_max

#################################################
func _dmg_label(dmg, pos):
	var new = preload("res://Tec/DmgLabel.tscn").instance()
	new.global_position = pos
	new.dmg = dmg
	get_tree().current_scene.add_child(new)

#################################################
func _pause():
	var new = preload("res://menu/PauseMenu.tscn").instance()
	get_tree().current_scene.add_child(new)

func _gameover():
	yield(get_tree().create_timer(2), "timeout")
	var newMenu = preload("res://menu/GameOverMenu.tscn").instance()
	get_tree().current_scene.add_child(newMenu)

func _stage_cleared():
	var new = preload("res://menu/StageClearedMenu.tscn").instance()
	get_tree().current_scene.add_child(new)

#################################################
func _id_to_label(id):
	return id.replace("_", " ").capitalize()
