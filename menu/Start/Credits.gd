extends "res://menu/Menu.gd"

########################################################################
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause") and !anim.is_playing():
		Utils._open_start()

func _on_BtnReturn_pressed():
	Utils._open_start()
