extends "res://menu/Menu.gd"

onready var labelCredits = $"%LabelCredits"
onready var labelEnemies = $"%LabelEnemies"
onready var labelList = [labelCredits, labelEnemies]

#################################################
func _ready():
	_make_invisible()
	_fill_label(labelCredits, "credits")
	_fill_label(labelEnemies, "enemies")
	_make_visible()

###
func _fill_label(label, element):
	var title = Utils._id_to_label(element)
	var playerResult = Utils.missionStats[element].player
	var LevelResult = Utils.missionStats[element].level
	label.text = "%s: %s of %s" % [title, playerResult, LevelResult]

###
func _make_invisible():
	for label in labelList:
		label.modulate = Color("00ffffff")

###
func _make_visible():
	for label in labelList:
		yield(get_tree().create_timer(0.5), "timeout")
		label.modulate = Color("ffffff")

#################################################
func _on_BtnHome_pressed():
	Utils._open_home()
