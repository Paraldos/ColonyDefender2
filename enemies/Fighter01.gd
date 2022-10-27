extends "res://enemies/Enemy.gd"

const PROJECTILE = preload("res://projectile/Projectile02.tscn")
onready var rayCast_right = $RayCast_Right
onready var rayCast_left = $RayCast_Left
onready var directionTimer = $DirectionTimer
onready var muzzle = $PositionMuzzle
var ACCELERATION = 25
var SPEED_MAX = 75
var velocity = Vector2(0, SPEED_MAX * 1.5)
var direction = 1


########################################################################
func _physics_process(_delta):
	_move()

func _move():
	_check_for_wall_collision()
	velocity.x += ACCELERATION * direction
	velocity.x = clamp(velocity.x, -SPEED_MAX, SPEED_MAX)
	velocity = move_and_slide(velocity)

func _check_for_wall_collision():
	if rayCast_right.is_colliding(): direction = -1
	if rayCast_left.is_colliding(): direction = 1

########################################################################
func _on_DirectionTimer_timeout():
	direction *= -1

########################################################################
func _on_AttackTimer_timeout():
	var new = PROJECTILE.instance()
	new.global_position = muzzle.global_position
	new.dmg = dmg
	get_tree().current_scene.add_child(new)
