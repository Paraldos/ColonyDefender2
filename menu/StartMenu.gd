extends "res://menu/Menu.gd"

########################################################################
func _on_BtnNew_pressed():
	Utils._new_game()
	SceneTransition.change_scene("res://world/World.tscn")

func _on_BtnCredits_pressed():
	SceneTransition.change_scene("res://menu/CreditsMenu.tscn")

func _on_BtnQuit_pressed():
	get_tree().quit()

###
func _on_BtnShop_pressed():
	Utils._new_game()
	SceneTransition.change_scene("res://Shop/Shop.tscn")
