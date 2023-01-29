extends Position2D

#################################################
const PROJECTILE = preload("res://enemies/Boss/SalvoProjectile.tscn")
onready var positionDirection = $PositionDirection
onready var anim = $Anim
export var bullets_per_attack = 7
export var scatter_angle = 10
var aktive = true

#################################################
func _attack(dmg):
	var alt_rotation = rotation_degrees
	for i in bullets_per_attack:
		if !aktive: return
		rotation_degrees = alt_rotation + Utils.rng.randi_range(-scatter_angle, scatter_angle)
		var dir = global_position - positionDirection.global_position
		var new = PROJECTILE.instance()
		new.global_position = global_position
		new.velocity = dir * 150
		new.dmg = dmg
		get_tree().current_scene.add_child(new)
		###
		anim.play("start")
		yield(anim, "animation_finished")
	rotation_degrees = alt_rotation

func _stop():
	aktive = false

