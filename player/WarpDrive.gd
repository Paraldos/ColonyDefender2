extends Node2D

var EXPLOSION = preload("res://explosions/Explosion03.tscn")
var AFTERIMAGE = preload("res://player/Afterimage.tscn")
onready var anim = $Anim
onready var sprite = $"../Sprite"
onready var timer = $TimerAfterImage
signal warp_done()

func _start():
	anim.play("start")

func _explosion():
	var new = EXPLOSION.instance()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)

func _position():
	timer.start()
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(
		get_parent(),
		"global_position",
		Vector2(Utils.window_width/2, -100),
		0.1)

func _on_TimerAfterImage_timeout():
	var new = AFTERIMAGE.instance()
	new.global_position = global_position
	new.scale = get_parent().scale
	get_tree().current_scene.add_child(new)
