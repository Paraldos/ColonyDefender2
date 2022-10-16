extends "res://menu/_Menu.gd"


########################################################################
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause") and !_is_playing():
		_stop()

########################################################################
func _on_BtnReturn_pressed():
	if _is_playing(): return
	_stop()

func _on_BtnQuit_pressed():
	if _is_playing(): return
	SceneTransition.change_scene("res://menu/StartMenu.tscn")

