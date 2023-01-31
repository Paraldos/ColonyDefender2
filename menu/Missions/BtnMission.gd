extends "res://theme/Button.gd"

var mission

func _on_BtnMission_pressed():
	Utils._start_new_mission()
	SceneTransition.change_scene(mission.file)

func _on_BtnMission_focus_entered():
	MySignals.emit_signal("mission_info", mission.description)
