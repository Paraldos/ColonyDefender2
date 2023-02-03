extends Node

var currentMission = []

########################################################################
class EnemyWave:
	var name = ""
	var type = "enemy"
	var waveTime = 10
	var spawnTimer = 0.8
	var background = ""
	var file = []
	var offsetX = 40
	var offsetY = 30

	func _init(name, file = [], waveTime = 10, spawnTimer = 0.8, background = "", offsetX = 20, offsetY = 20):
		self.name = name
		self.file = file
		self.waveTime = waveTime
		self.spawnTimer = spawnTimer
		self.background = background
		self.offsetX = offsetX
		self.offsetY = offsetY

	func _start_background():
		if background != "":
			MySignals.emit_signal("start_background_particles", background)

	func _get_file():
		return file[ Utils.rng.randi_range(0, file.size() -1) ]
	
	func _get_start_position():
		var posX = Utils.rng.randi_range(offsetX, Utils.window_width -offsetX)
		var posY = -offsetY
		return Vector2(posX, posY)

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
	[preload("res://enemies/Fighters/Pirate_Fighter.tscn")],
	10, 0.9)

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
	20, 0.8, "Asteroids")

var DEBRIS = EnemyWave.new(
	"DEBRIS",
	[	preload("res://enemies/Debris/Debris01.tscn"),
		preload("res://enemies/Debris/Debris02.tscn"),
		preload("res://enemies/Debris/Debris03.tscn"),
		preload("res://enemies/Debris/Debris04.tscn"),
		preload("res://enemies/Debris/Debris05.tscn"),
		preload("res://enemies/Debris/Debris06.tscn")],
	20, 0.8, "Debris")

var GUNSHIPS = EnemyWave.new(
	"GUNSHIPS",
	[preload("res://enemies/Gunship/Gunship.tscn")],
	8, 1.2)

var MISSILES = EnemyWave.new(
	"MISSILES",
	[preload("res://enemies/Missiles/Missile.tscn")],
	8, 0.5)

var CRABSHIP = EnemyWave.new(
	"CRABSHIP",
	[preload("res://enemies/Crabship/CrabShip.tscn")],
	10, 1.4)

### premade boss waves
const PIRATEBOSS = {
	name = "PIRATEBOSS",
	spawnTimer = 3,
	type = "boss",
	file = preload("res://enemies/Boss/PirateBoss/PirateBoss.tscn")
}

const PIRATEBASE = {
	name = "PIRATEBASE",
	spawnTimer = 3,
	type = "boss",
	file = preload("res://enemies/Boss/Pirate_Base.tscn")
}

### dialog wave:
#{ type = "dialog", timeline = "Hello", spawnTimer = 0 },

### end of stage
#{ type = "endOfStage", spawnTimer = 0, wait_time = 3 }

########################################################################
var MISSIONS = [
	{	title = "Ahoi Commander",
		description = "Welcome to Lantia III Commander. This cozy little colony on the edge of federation space is your new home - at least for now. Your first mission will be a simple patrole through a nearby asteroid field.",
		waves = [
			{ type = "dialog", timeline = "AhoiCommander1", spawnTimer = 0 },
			ASTEROIDS,
			ASTEROIDS,
			DEBRIS,
			{ type = "dialog", timeline = "AhoiCommander2", spawnTimer = 1 },
			PIRATE_FIGHTER,
			DEBRIS,
			PIRATE_FIGHTER,
			{ type = "dialog", timeline = "AhoiCommander3", spawnTimer = 4 },
			{ type = "endOfStage", spawnTimer = 0.5, wait_time = 1 }
		]
	},
	#################################################
	{	title = "Pirate Hunt",
		description = "One of our security outposts has spotted more pirate signatures. How about you fly out there, and show them that a new sheriff is in town?",
		waves = [
			{ type = "dialog", timeline = "PirateHunt1", spawnTimer = 0 },
			ASTEROIDS,
			ASTEROIDS,
			PIRATE_FIGHTER,
			PIRATE_FIGHTER,
			MISSILES,
			PIRATE_FIGHTER,
			PIRATEBOSS,
			{ type = "endOfStage", spawnTimer = 0.1, wait_time = 3 }
		]
	},
	#################################################
		{	title = "Pirate Base",
		description = "We found the piartes home Base. It's hidden in an asteroid field on the very edge of the system. They certainly will know you are comming. Prepare for a hard fight.",
		waves = [
			PIRATEBOSS,
			{ type = "endOfStage", spawnTimer = 0.1, wait_time = 3 }
		]
	},
	#################################################
]
