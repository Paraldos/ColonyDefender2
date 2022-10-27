extends "res://menu/Menu.gd"

#################################################
func _ready():
	pass

#################################################
func _on_CreditsLabel_count_up_done():
	pass # Replace with function body.

#################################################
func _on_BtnNextStage_pressed():
	Utils._next_stage()
	SceneTransition.change_scene("res://world/World.tscn")

func _on_BtnShop_pressed():
	SceneTransition.change_scene("res://Shop/Shop.tscn")
