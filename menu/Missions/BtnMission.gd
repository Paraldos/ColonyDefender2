extends "res://theme/BtnTemplate.gd"

var mission

func _on_BtnMission_pressed():
	Utils._start_new_mission()
	MyMissions.currentMission = mission
	MySceneTransition.change_scene("res://Battle/Battle.tscn")

func _on_BtnMission_focus_entered():
	MySignals.emit_signal("mission_info", mission.description)
