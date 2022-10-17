extends Node2D

########################################################################
onready var gunTimer = $Timer
onready var gunAudio = $Audio
onready var muzzle = $Position
var gunDMG = 5
var gunSpeed = -300

### attack
func _attack():
	if Input.is_action_pressed("ui_attack") and gunTimer.is_stopped():
		gunTimer.start()
		_attack_audio()
		_instance_projectile()

const PROJECTILE = preload("res://projectile/Projectile01.tscn")

func _instance_projectile():
	var new = PROJECTILE.instance()
	new.position = muzzle.global_position
	new.dmg = gunDMG + Utils.rng.randi_range(-1, 1)
	new.velocity = Vector2(0, gunSpeed)
	get_tree().current_scene.add_child(new)

func _attack_audio():
	gunAudio.pitch_scale = Utils.rng.randf_range(0.90, 1.1)
	gunAudio.play()

