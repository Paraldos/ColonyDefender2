extends "res://Missions/template/MissionTemplate.gd"

func _ready():
	mission = [
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
