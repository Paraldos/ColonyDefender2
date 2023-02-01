extends "res://menu/Menu.gd"

func _on_BtnAgain_pressed():
	Utils._abort_mission()
	Utils._start_new_mission()
	get_tree().reload_current_scene()

func _on_BtnBack_pressed():
	Utils._abort_mission()
	Utils._open_home()
