extends "res://menu/Menu.gd"

func _on_BtnAgain_pressed():
	Utils._new_game()
	SceneTransition.change_scene("res://world/#World.tscn")

func _on_BtnBack_pressed():
	SceneTransition.change_scene("res://menu/StartMenu.tscn")
