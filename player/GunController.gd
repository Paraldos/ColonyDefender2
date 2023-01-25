extends Node2D

########################################################################
onready var gunTimer = $Timer
onready var gunAudio = $Audio
onready var anim = $Anim
var projectileSpeed = -300
const PROJECTILE = preload("res://player/Projectile.tscn")

### attack
func _attack():
	if Input.is_action_pressed("ui_attack") and gunTimer.is_stopped():
		gunTimer.start()
		_attack_audio()
		anim.play("attack")
		_instance_projectile(-5)
		_instance_projectile(5)

func _instance_projectile(offsetX):
	var new = PROJECTILE.instance()
	new.position = global_position + Vector2(offsetX, 0)
	new.dmg = Utils._get_gun_dmg()
	new.velocity = Vector2(0, projectileSpeed)
	get_tree().current_scene.add_child(new)


func _attack_audio():
	gunAudio.pitch_scale = Utils.rng.randf_range(0.90, 1.1)
	gunAudio.play()

