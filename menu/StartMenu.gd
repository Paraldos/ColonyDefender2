extends "res://menu/Menu.gd"

########################################################################
func _on_BtnNew_pressed():
	Utils._new_game()
	SceneTransition.change_scene("res://world/World.tscn")

func _on_BtnQuit_pressed():
	get_tree().quit()
