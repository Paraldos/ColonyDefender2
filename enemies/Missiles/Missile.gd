extends "res://enemies/Enemy.gd"

var velocity = Vector2(0, 800)
var move = false
onready var hitbox = $Sprite/Hitbox
onready var audio = $Audio

########################################################################
func _ready():
	audio.pitch_scale = Utils.rng.randf_range(0.9, 1.1)

func _physics_process(_delta):
	hitbox.dmg = dmg
	if move:
		velocity = move_and_slide(velocity)

func _start():
	move = true


