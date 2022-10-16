extends Node2D

#################################################
onready var hitbox = $Hitbox
onready var bomb = $Animation/Bomb
onready var audioExplosion = $AudioExplosion

#################################################
func _ready():
	hitbox.dmg = Utils.player.megabomb_dmg

#################################################
func _physics_process(_delta):
	var x = 1
	bomb.offset.x = Utils.rng.randf_range(-x, x)
	bomb.offset.y = Utils.rng.randf_range(-x, x)
