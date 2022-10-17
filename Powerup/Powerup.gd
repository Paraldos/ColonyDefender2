extends Node2D
class_name PowerUp

onready var magnet_shape = $Sprite/AreaMagnet/CS
onready var anim = $Anim
var magnetised = false
var move_vector = Vector2(0, 0.8)
var magnet_speed = 0
var magnet_speed_max = 0.4
var magnet_acc = 0.01

#################################################
func _ready():
	magnet_shape.shape.radius = Utils.player.magnet_distance

#################################################
func _physics_process(_delta):
	if !magnetised:
		if move_vector.x != 0:
			move_vector.x = lerp(move_vector.x, 0, 0.04)
		if move_vector.y != 0:
			move_vector.y = lerp(move_vector.y, 0.8, 0.04)
		global_position += move_vector
	if magnetised:
		magnet_speed += magnet_acc
		magnet_speed = clamp(magnet_speed, 0, magnet_speed_max)
		global_position = lerp(global_position, Utils.player_pos, magnet_speed)

#################################################
func _on_AreaMagnet_body_entered(_body):
	magnetised = true

#################################################
func _on_AreaCollect_body_entered(_body):
	if anim.is_playing(): return
	anim.play("pickup")
	_pickup()

const EXPLOSION = preload("res://explosions/Explosion04.tscn")

func explosion():
	var new = EXPLOSION.instance()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)

func _pickup():
	pass

#################################################
func _on_VisibilityNotifier_screen_exited():
	queue_free()
