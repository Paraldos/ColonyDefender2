extends "res://menu/Menu.gd"

onready var buttons = $"%Buttons"
onready var description = $"%Description"
var btnMission = preload("res://menu/Missions/BtnMission.tscn")

########################################################################
### waves
const FIGHTERS1 = {
	type = "enemy",
	waveTime = 10,
	spawnTimer = 0.8,
	file = [preload("res://enemies/Fighters/Fighter01.tscn")],
	offsetX = 40,
	offsetY = 30,
}
const FIGHTERS2 = {
	type = "enemy",
	waveTime = 10,
	spawnTimer = 0.6,
	file = [preload("res://enemies/Fighters/Fighter02.tscn")],
	offsetX = 20,
	offsetY = 20,
}
const PIRATE_FIGHTER = {
	type = "enemy",
	waveTime = 10,
	spawnTimer = 0.9,
	file = [preload("res://enemies/Fighters/Pirate_Fighter.tscn")],
	offsetX = 20,
	offsetY = 20,
}
const ASTEROIDS = {
	type = "enemy",
	waveTime = 20,
	spawnTimer = 0.8,
	file = [
		preload("res://enemies/Asteroids/Asteroid01.tscn"),
		preload("res://enemies/Asteroids/Asteroid02.tscn"),
		preload("res://enemies/Asteroids/Asteroid03.tscn"),
		preload("res://enemies/Asteroids/Asteroid04.tscn"),
		preload("res://enemies/Asteroids/Asteroid05.tscn"),
		preload("res://enemies/Asteroids/Asteroid06.tscn"),
		preload("res://enemies/Asteroids/Asteroid07.tscn"),
		preload("res://enemies/Asteroids/Asteroid08.tscn"),
		preload("res://enemies/Asteroids/Asteroid09.tscn"),
		preload("res://enemies/Asteroids/Asteroid10.tscn"),
		preload("res://enemies/Asteroids/Asteroid11.tscn"),
		preload("res://enemies/Asteroids/Asteroid12.tscn"),
		preload("res://enemies/Asteroids/ExplosiveAsteroid.tscn")
	],
	offsetX = 20,
	offsetY = 20,
}
const DEBRIS = {
	type = "enemy",
	waveTime = 20,
	spawnTimer = 0.8,
	file = [
		preload("res://enemies/Debris/Debris01.tscn"),
		preload("res://enemies/Debris/Debris02.tscn"),
		preload("res://enemies/Debris/Debris03.tscn"),
		preload("res://enemies/Debris/Debris04.tscn"),
		preload("res://enemies/Debris/Debris05.tscn"),
		preload("res://enemies/Debris/Debris06.tscn"),
	],
	offsetX = 20,
	offsetY = 20,
}
const GUNSHIPS = {
	type = "enemy",
	waveTime = 8,
	spawnTimer = 1.2,
	file = [preload("res://enemies/Gunship/Gunship.tscn")],
	offsetX = 40,
	offsetY = 30,
}
const MISSILES = {
	type = "enemy",
	waveTime = 8,
	spawnTimer = 0.5,
	file = [preload("res://enemies/Missiles/Missile.tscn")],
	offsetX = 20,
	offsetY = 30,
}
const CRABSHIP = {
	type = "enemy",
	waveTime = 10,
	spawnTimer = 1.4,
	file = [preload("res://enemies/Crabship/CrabShip.tscn")],
	offsetX = 40,
	offsetY = 30,
}
const PIRATE_BOSS = {
	spawnTimer = 3,
	type = "boss",
	file = preload("res://enemies/Boss/Pirate_Boss.tscn"),
}

### Missions
var missions = [
	{	title = "Ahoi Commander",
		file = "res://Missions/Missions/AhoiCommander.tscn",
		description = "Welcome to Lantia III Commander. This cozy little colony on the edge of federation space is your new home. Your first mission will be a simple patrole through a nearby asteroid field.",
		waves = [
			{ type = "dialog", timeline = "AhoiCommander1", spawnTimer = 0 },
			ASTEROIDS,
			ASTEROIDS,
			DEBRIS,
			{ type = "dialog", timeline = "AhoiCommander2", spawnTimer = 1 },
			PIRATE_FIGHTER,
			DEBRIS,
			PIRATE_FIGHTER,
			{ type = "dialog", timeline = "AhoiCommander3", spawnTimer = 1 },
		]
	},
	{
		title = "Pirate Hunt",
		file = "res://Missions/Missions/AhoiCommander.tscn",
		description = "test123",
		waves = [
			{type = "dialog", timeline = "AhoiCommander1", spawnTimer = 0},
			ASTEROIDS,
			ASTEROIDS,
			DEBRIS,
			{type = "dialog", timeline = "AhoiCommander2", spawnTimer = 0},
			PIRATE_FIGHTER,
			DEBRIS,
			PIRATE_FIGHTER,
			{type = "dialog", timeline = "AhoiCommander3", spawnTimer = 0},
		]
	}
]

########################################################################
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
