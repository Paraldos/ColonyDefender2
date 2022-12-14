extends "res://enemies/Enemy.gd"

onready var hitbox = $Sprite/Hitbox
var velocity = Vector2(Utils.rng.randi_range(-25, 25), Utils.rng.randi_range(100, 150))

########################################################################
func _ready():
	_randomize()
	hitbox.dmg = dmg

func _randomize():
	var size = Utils.rng.randf_range(0.9, 1.1)
	scale.x = size
	scale.y = size
	###
	var rot = Utils.rng.randi_range(-15, 15)
	rotation_degrees = rot

########################################################################
func _physics_process(_delta):
	velocity = move_and_slide(velocity)


