extends Node2D

########################################################################
onready var hitbox = $Hitbox
onready var particles = $Particles

export var velocity = Vector2.ZERO
export(int) var explosion = 0
export var dmg = 1
export var emitting_particles = false
export var rotate = 0
export(String, "Player", "Enemies") var target = "Player"

########################################################################
func _ready():
	hitbox.dmg = dmg
	particles.emitting = emitting_particles
	rotation_degrees += rotate
	match target:
		"Player": pass
		"Enemies": pass

########################################################################
func _physics_process(delta):
	position += velocity * delta

########################################################################
func _on_VisibilityNotifier_screen_exited():
	queue_free()

########################################################################
func _on_Hitbox_area_entered(_area):
	_add_explosion()
	queue_free()

const EXPLOSIONS = [
	null,
	preload("res://explosions/Explosion01.tscn"),
	preload("res://explosions/Explosion02.tscn"),
	preload("res://explosions/Explosion03.tscn"),
	preload("res://explosions/Explosion04.tscn")
]

func _add_explosion():
	if explosion <= 0: return
	var new = EXPLOSIONS[explosion].instance()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)



