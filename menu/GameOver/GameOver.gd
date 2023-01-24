extends "res://menu/Menu.gd"

func _on_BtnAgain_pressed():
	Utils._new_game()
	Utils._open_world()

func _on_BtnBack_pressed():
	Utils._open_start()
