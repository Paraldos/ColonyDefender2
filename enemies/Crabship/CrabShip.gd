extends "res://enemies/Enemy.gd"

onready var animMuzzle = $PositionMuzzle/AnimMuzzle
onready var muzzle = $PositionMuzzle
onready var muzzleDirection = $PositionMuzzle/Direction
onready var audio = $Audio
var velocity = Vector2(0, Utils.rng.randi_range(80, 120))

########################################################################
func _physics_process(_delta):
	velocity = move_and_slide(velocity)

########################################################################
func _on_AttackTimer_timeout():
	_attack_audio()
	muzzle.look_at(Utils.player_pos)
	animMuzzle.play("attack")
	var dir = muzzle.global_position - muzzleDirection.global_position
	_instance_projectile(dir * 150)

func _attack_audio():
	audio.pitch_scale = Utils.rng.randf_range(0.80, 1.2)
	audio.play()

func _instance_projectile(speed):
	var new = preload("res://enemies/Crabship/Projectile.tscn").instance()
	new.global_position = muzzle.global_position
	new.velocity = Vector2(speed.x, speed.y)
	new.dmg = dmg
	get_tree().current_scene.add_child(new)
