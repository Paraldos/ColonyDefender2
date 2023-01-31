extends "res://menu/Menu.gd"

onready var buttons = $"%Buttons"
onready var description = $"%Description"

var btnMission = preload("res://menu/Missions/BtnMission.tscn")
var missions = [
	{	title = "Ahoi Commander",
		file = "res://Missions/Missions/AhoiCommander.tscn",
		description = "test123"
	},
]

#################################################
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		_stop()

########################################################################
func _ready():
	MySignals.connect("mission_info", self, "_on_mission_info")
	_clean_buttons()
	_fill_buttons()

func _clean_buttons():
	for item in buttons.get_children():
		item.queue_free()

func _fill_buttons():
	for mission in missions:
		var new = btnMission.instance()
		new.mission = mission
		new.labelText = mission.title
		buttons.add_child(new)

func _on_mission_info(txt):
	description.text = txt

########################################################################
func _on_BtnExit_pressed():
	if anim.is_playing(): return
	_stop()
