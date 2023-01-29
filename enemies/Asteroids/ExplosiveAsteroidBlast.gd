extends KinematicBody2D

var dmg = 0
onready var hitbox = $"%Hitbox"

func _ready():
	hitbox.dmg = dmg
