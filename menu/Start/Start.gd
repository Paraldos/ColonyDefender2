extends "res://menu/Menu.gd"

onready var btnNew = $C/MC/VC/BtnNew

########################################################################
func _ready():
	btnNew.grab_focus()

########################################################################
func _on_BtnNew_pressed():
	Utils._new_game()
	Utils._open_home()

func _on_BtnCredits_pressed():
	Utils._open_credits()

func _on_BtnQuit_pressed():
	get_tree().quit()

