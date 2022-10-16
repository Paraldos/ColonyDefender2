extends Node

#################################################
var rng = RandomNumberGenerator.new()
var window_width = 480
var window_height = 270
var wave = 0
var newPlayer = {
	credits = 0,
	hp_max = 50,
	hp = 50,
	energy_max = 4,
	energy = 4,
	megabomb_dmg = 40,
	megalaser_dmg = 20,
	magnet_distance = 100
}
var player = {}
var player_pos

#################################################
func _ready():
	rng.randomize()

#################################################
func _new_game():
	wave = 0
	player = newPlayer.duplicate()

#################################################
func _dmg_label(dmg, pos):
	var new = MyPreload.DMGLABEL.instance()
	new.global_position = pos
	new.dmg = dmg
	get_tree().current_scene.add_child(new)

#################################################
func _pause():
	var new = MyPreload.PAUSEMENU.instance()
	get_tree().current_scene.add_child(new)

func _gameover():
	yield(get_tree().create_timer(2), "timeout")
	var newMenu = MyPreload.GAMEOVERMENU.instance()
	get_tree().current_scene.add_child(newMenu)
