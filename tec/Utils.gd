extends Node

#################################################
var rng = RandomNumberGenerator.new()
var window_width = 480
var window_height = 270
var newPlayer = {
	credits = 0,
	hp = 50,
	energy_max = 4,
	energy = 4,
	megabomb_dmg = 40,
	megalaser_dmg = 20,
	magnet_distance = 100,
	### upgrades
	gun_level = 0,
	health_level = 0,
}
var oldPlayer = {}
var player = {}
var player_pos
var player_node

#################################################
func _get_gun_dmg():
	return 3 + Utils.player.gun_level

func _get_hp_max():
	return 50 + (player.health_level * 10)

#################################################
func _enter_tree():
	rng.randomize()

#################################################
func _new_game():
	player = newPlayer.duplicate()
	_next_stage()

func _next_stage():
	oldPlayer = player.duplicate()
	player.hp = _get_hp_max()
	player.energy = player.energy_max

#################################################
# Helper
func _dmg_label(dmg, pos):
	var new = preload("res://Tec/DmgLabel.tscn").instance()
	new.global_position = pos
	new.dmg = dmg
	get_tree().current_scene.add_child(new)

func _id_to_label(id):
	return id.replace("_", " ").capitalize()

#################################################
# menus and new scenes
func _open_world():
	SceneTransition.change_scene("res://world/World.tscn")

func _open_start():
	SceneTransition.change_scene("res://menu/Start/Start.tscn")

func _open_credits():
	SceneTransition.change_scene("res://menu/Start/Credits.tscn")

func _open_shop():
	var new = preload("res://menu/Shop/Shop.tscn").instance()
	get_tree().current_scene.add_child(new)

func _open_pause():
	var new = preload("res://menu/Pause/Pause.tscn").instance()
	get_tree().current_scene.add_child(new)

func _open_gameover():
	yield(get_tree().create_timer(2), "timeout")
	var new = preload("res://menu/GameOver/GameOver.tscn").instance()
	get_tree().current_scene.add_child(new)

func _open_stage_cleared():
	var new = preload("res://menu/StageCleared/StageCleared.tscn").instance()
	get_tree().current_scene.add_child(new)









