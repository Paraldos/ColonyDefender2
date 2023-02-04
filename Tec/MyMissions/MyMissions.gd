extends Node

var currentMission = []

########################################################################
class EnemyWave:
	var name = ""
	var type = "enemy"
	var timer = 0
	var counter = 0
	var file = []

	func _init(name, file = [], timer = 0.8, counter = 10):
		self.name = name
		self.file = file
		self.timer = timer
		self.counter = counter

	func _get_start_position():
		var posX = Utils.rng.randi_range(32, Utils.window_width -32)
		return Vector2(posX, -16)

	func _get_file():
		return file[ Utils.rng.randi_range(0, file.size() -1) ]

########################################################################
### premade enemy waves
var FIGHTERS1 = EnemyWave.new(
	"FIGHTERS3",
	[ preload("res://enemies/Fighters/Fighter01.tscn")])

var FIGHTERS2 = EnemyWave.new(
	"FIGHTERS2",
	[ preload("res://enemies/Fighters/Fighter02.tscn")])

var PIRATE_FIGHTER = EnemyWave.new(
	"PIRATE_FIGHTER",
	[preload("res://enemies/Fighters/Pirate_Fighter.tscn")])

var ASTEROIDS = EnemyWave.new(
	"ASTEROIDS",
	[	preload("res://enemies/Asteroids/Asteroid01.tscn"),
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
		preload("res://enemies/Asteroids/ExplosiveAsteroid.tscn")],
	0.8, 20)

var DEBRIS = EnemyWave.new(
	"DEBRIS",
	[	preload("res://enemies/Debris/Debris01.tscn"),
		preload("res://enemies/Debris/Debris02.tscn"),
		preload("res://enemies/Debris/Debris03.tscn"),
		preload("res://enemies/Debris/Debris04.tscn"),
		preload("res://enemies/Debris/Debris05.tscn"),
		preload("res://enemies/Debris/Debris06.tscn")],
	0.8, 20)

var GUNSHIPS = EnemyWave.new(
	"GUNSHIPS",
	[preload("res://enemies/Gunship/Gunship.tscn")],
	1.2, 6)

var MISSILES = EnemyWave.new(
	"MISSILES",
	[preload("res://enemies/Missiles/Missile.tscn")],
	0.8, 10)

var CRABSHIP = EnemyWave.new(
	"CRABSHIP",
	[preload("res://enemies/Crabship/CrabShip.tscn")],
	10, 1.4)

### premade boss waves
const PIRATEBOSS = {
	name = "PIRATEBOSS",
	timer = 3,
	type = "boss",
	file = preload("res://enemies/Boss/PirateBoss/PirateBoss.tscn")
}

const PIRATEBASE = {
	name = "PIRATEBASE",
	timer = 3,
	type = "boss",
	file = preload("res://enemies/Boss/PirateBase/PirateBase.tscn")
}

########################################################################
var MISSIONS = [
	{	title = "Ahoi Commander",
		description = "Welcome to Lantia III Commander. This cozy little colony on the edge of federation space is your new home - at least for now. Your first mission will be a simple patrole through a nearby asteroid field.",
		waves = [
			{ type = "dialog", timeline = "AhoiCommander1"},
			{ type = "particles", background = "Asteroids"},
			ASTEROIDS,
			ASTEROIDS,
			{ type = "particles", background = "Debris"},
			DEBRIS,
			{ type = "dialog", timeline = "AhoiCommander2"},
			PIRATE_FIGHTER,
			DEBRIS,
			PIRATE_FIGHTER,
			{ type = "particles", background = ""},
			{ type = "dialog", timeline = "AhoiCommander3"},
			{ type = "endOfStage", timer = 1 }
		]
	},
	#################################################
	{	title = "Pirate Hunt",
		description = "One of our security outposts has spotted more pirate signatures. How about you fly out there, and show them that a new sheriff is in town?",
		waves = [
			{ type = "dialog", timeline = "PirateHunt1", spawnTimer = 0 },
			{ type = "particles", background = "Asteroids"},
			ASTEROIDS,
			ASTEROIDS,
			PIRATE_FIGHTER,
			PIRATE_FIGHTER,
			{ type = "particles", background = ""},
			{ type = "dialog", timeline = "PirateHunt2", spawnTimer = 0 },
			MISSILES,
			PIRATE_FIGHTER,
			PIRATEBOSS,
			{ type = "endOfStage", timer = 3 }
		]
	},
	#################################################
		{	title = "Pirate Base",
		description = "We found the piartes home Base. It's hidden in an asteroid field on the very edge of the system. They certainly will know you are comming. Prepare for a hard fight.",
		waves = [
			PIRATEBASE,
			{ type = "endOfStage", timer = 3 }
		]
	},
	#################################################
]
