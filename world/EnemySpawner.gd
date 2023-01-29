extends Node2D

onready var timerWave = $TimerWave
onready var timerSpawn = $TimerSpawn
var wave = {}
var waveCounter = 0
var wavesToBoss = 5

const FIGHTERS1 = {
	name = "fighters1",
	waveTime = 10,
	spawnTimer = 0.8,
	file = preload("res://enemies/Fighters/Fighter01.tscn"),
	offsetX = 40,
	offsetY = 30
}

const FIGHTERS2 = {
	name = "fighters2",
	waveTime = 10,
	spawnTimer = 0.6,
	file = preload("res://enemies/Fighters/Fighter02.tscn"),
	offsetX = 20,
	offsetY = 20
}

const FIGHTERS_PIRATE = {
	name = "fighters_pirate",
	waveTime = 10,
	spawnTimer = 0.9,
	file = preload("res://enemies/Fighters/Fighter_Pirate.tscn"),
	offsetX = 20,
	offsetY = 20
}

const ASTEROIDS = {
	name = "asteroids",
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
	offsetY = 20
}

const DEBRIS = {
	name = "debris",
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
	offsetY = 20
}

const GUNSHIPS = {
	name = "gunships",
	waveTime = 8,
	spawnTimer = 1.2,
	file = preload("res://enemies/Gunship/Gunship.tscn"),
	offsetX = 40,
	offsetY = 30
}

const MISSILES = {
	name = "missiles",
	waveTime = 8,
	spawnTimer = 0.5,
	file = preload("res://enemies/Missiles/Missile.tscn"),
	offsetX = 20,
	offsetY = 30
}

const CRABSHIP = {
	name = "crabships",
	waveTime = 10,
	spawnTimer = 1.4,
	file = preload("res://enemies/Crabship/CrabShip.tscn"),
	offsetX = 40,
	offsetY = 30
}

const WAVES = [
	FIGHTERS1,
	FIGHTERS2,
	FIGHTERS_PIRATE,
	ASTEROIDS,
	DEBRIS,
	GUNSHIPS,
	MISSILES,
	CRABSHIP
]

########################################################################
func _ready():
	timerWave.start(3)

########################################################################
### spawn during wave
func _on_TimerSpawn_timeout():
	timerSpawn.start(wave.spawnTimer)
	var new = _get_file().instance()
	new.global_position = _start_position()
	add_child(new)

func _get_file():
	if(typeof(wave.file) == 19):
		return wave.file[Utils.rng.randi_range(0, wave.file.size() -1)]
	else:
		return wave.file

func _start_position():
	var posX = Utils.rng.randi_range(wave.offsetX, Utils.window_width -wave.offsetX)
	var posY = -wave.offsetY
	return Vector2(posX, posY)

########################################################################
### next wave
func _on_TimerWave_timeout():
	_stop_old_wave()
	if waveCounter >= wavesToBoss: 
		_spawn_boss()
	else: 
		_next_wave()

### stop old wave
func _stop_old_wave():
	timerSpawn.stop()
	MySignals.emit_signal("asteroids_stop")
	MySignals.emit_signal("debris_stop")

### spawn boss
func _spawn_boss():
	timerWave.stop()
	MySignals.emit_signal("stop_background")
	### spawn boss
	yield(get_tree().create_timer(3), "timeout")
	var new = preload("res://enemies/Boss/Pirate_Boss.tscn").instance()
	add_child(new)

### spawn enemy
func _next_wave():
	### start wave
	wave = WAVES[Utils.rng.randi_range(0, WAVES.size()-1)]
	timerWave.start(wave.waveTime)
	timerSpawn.start(wave.spawnTimer)
	### start background if needed
	if wave.name == "asteroids": MySignals.emit_signal("asteroids_start")
	if wave.name == "debris": MySignals.emit_signal("debris_start")
	### wave counter +1
	waveCounter += 1


