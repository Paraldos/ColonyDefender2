extends "res://enemies/Enemy.gd"

########################################################################
const PROJECTILE = preload("res://enemies/Gunship/Projectile.tscn")
onready var muzzle = $PositionMuzzle
var velocity = Vector2(0, Utils.rng.randi_range(80, 110))

########################################################################
func _physics_process(_delta):
	velocity = move_and_slide(velocity)

########################################################################
func _on_AttackTimer_timeout():
	_instance_projectile(Vector2(100, 250))
	_instance_projectile(Vector2(-100, 250))

func _instance_projectile(speed):
	var new = PROJECTILE.instance()
	new.global_position = muzzle.global_position
	new.velocity = Vector2(speed.x, speed.y)
	new.dmg = dmg
	get_tree().current_scene.add_child(new)



