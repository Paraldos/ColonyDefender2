extends "res://menu/Menu.gd"

########################################################################
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause") and !anim.is_playing():
		_stop()

########################################################################
func _on_BtnReturn_pressed():
	_stop()

func _on_BtnQuit_pressed():
	Utils._open_start()
