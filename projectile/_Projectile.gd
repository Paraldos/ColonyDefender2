extends Node2D

########################################################################
onready var hitbox = $Hitbox_
onready var particles = $Particles

export var velocity = Vector2.ZERO
export(int) var explosion = 0
export var dmg = 1
export var emitting_particles = false
export var rotate = 0

########################################################################
func _ready():
	hitbox.dmg = dmg
	particles.emitting = emitting_particles
	rotation_degrees += rotate

########################################################################
func _physics_process(delta):
	position += velocity * delta

########################################################################
func _on_VisibilityNotifier_screen_exited():
	queue_free()

########################################################################
func _on_Hitbox__area_entered(area):
	_add_explosion()
	queue_free()

func _add_explosion():
	if explosion <= 0: return
	var new = MyPreload.EXPLOSIONS[explosion].instance()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)


