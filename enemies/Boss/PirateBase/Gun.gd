extends Node2D

var active = true

func _physics_process(_delta):
	if Utils.player_pos and active: 
		look_at(Utils.player_pos)

func _stop():
	active = false

