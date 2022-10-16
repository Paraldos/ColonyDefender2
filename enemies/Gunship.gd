extends "res://enemies/_Enemy.gd"

########################################################################
onready var muzzle = $PositionMuzzle
var velocity = Vector2(0, Utils.rng.randi_range(120, 180))

########################################################################
func _physics_process(_delta):
	velocity = move_and_slide(velocity)

########################################################################
func _on_AttackTimer_timeout():
	###
	var new = MyPreload.PROJECTILE[3].instance()
	new.global_position = muzzle.global_position
	new.velocity = Vector2(50, 150)
	new.dmg = dmg
	get_tree().current_scene.add_child(new)
	###
	var new2 = MyPreload.PROJECTILE[3].instance()
	new2.global_position = muzzle.global_position
	new2.velocity = Vector2(-50, 150)
	new2.dmg = dmg
	get_tree().current_scene.add_child(new2)
