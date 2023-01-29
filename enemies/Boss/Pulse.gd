extends Position2D

#################################################
const PROJECTILE = preload("res://enemies/Boss/PulseProjectile.tscn")
onready var positionDirection = $PositionDirection
onready var audio = $Audio
onready var anim = $Anim
export var divider = 8
var aktive = true

#################################################
func _attack(dmg):
	anim.play("start")
	for i in divider:
		if !aktive: return
		audio.play()
		rotation_degrees = (i) * (360 / divider)
		var dir = global_position - positionDirection.global_position
		var new = PROJECTILE.instance()
		new.global_position = global_position
		new.velocity = dir * 150
		new.dmg = dmg
		get_tree().current_scene.add_child(new)

func _stop():
	aktive = false

