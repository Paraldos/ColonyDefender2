extends Node2D

onready var timerWave = $TimerWave
onready var timerSpawn = $TimerSpawn
var cWave = {}
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
const MISSION = [
	{type = "dialog", timeline="HelloWorld", spawnTimer = 0},
	PIRATE_FIGHTER,
	PIRATE_FIGHTER,
	PIRATE_BOSS,
]

########################################################################
func _ready():
	timerWave.start(3)

########################################################################
### spawn during wave
func _on_TimerSpawn_timeout():
	match cWave.type:
		"enemy": _spawn_enemy()
		"boss": _spawn_boss()
		"dialog": _spawn_dialog()

### spawn dialog
func _spawn_dialog():
	var new_dialog = Dialogic.start(cWave.timeline)
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "_on_timeline_end")

func _on_timeline_end(_timeline):
	yield(get_tree().create_timer(3), "timeout")
	_next_wave()

### spawn boss
func _spawn_boss():
	#yield(get_tree().create_timer(3), "timeout")
	var new = cWave.file.instance()
	add_child(new)

### spawn enemy
func _spawn_enemy():
	timerSpawn.start(cWave.spawnTimer)
	var new = cWave.file[Utils.rng.randi_range(0, cWave.file.size() -1)].instance()
	new.global_position = _get_start_position()
	add_child(new)

func _get_start_position():
	var posX = Utils.rng.randi_range(cWave.offsetX, Utils.window_width -cWave.offsetX)
	var posY = -cWave.offsetY
	return Vector2(posX, posY)

########################################################################
### next wave
func _on_TimerWave_timeout(): _next_wave()

func _next_wave():
	if MISSION.size() <= 0:
		MySignals.emit_signal("end_stage")
	else:
		_stop_old_wave()
		_select_next_wave()
		_start_next_wave()
		_start_wave_background()

func _stop_old_wave():
	timerSpawn.stop()
	MySignals.emit_signal("asteroids_stop")
	MySignals.emit_signal("debris_stop")

func _select_next_wave():
	cWave = MISSION.pop_front()

func _start_next_wave():
	timerSpawn.start(cWave.spawnTimer)
	if cWave.type == "enemy":
		timerWave.start(cWave.waveTime)

func _start_wave_background():
	if cWave == ASTEROIDS: MySignals.emit_signal("asteroids_start")
	if cWave == DEBRIS: MySignals.emit_signal("debris_start")


