extends Node2D

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause") and Utils.pause_posible:
		Utils._pause()
