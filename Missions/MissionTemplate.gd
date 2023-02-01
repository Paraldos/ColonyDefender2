extends Node2D

onready var timerWave = $TimerWave
onready var timerSpawn = $TimerSpawn
var mission = [
	#{ type = "dialog", timeline = "Hello", spawnTimer = 0 },
	#{ type = "endOfStage", spawnTimer = 0, wait_time = 3 }
]
var currentWave = {}

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

########################################################################
func _ready():
	timerWave.start(3)

########################################################################
func _input(event):
	if Input.is_action_just_pressed("ui_pause"):
		if get_tree().get_nodes_in_group("menus").size() <= 0:
			Utils._open_pause()

########################################################################
### spawn during wave
func _on_TimerSpawn_timeout():
	match currentWave.type:
		"enemy": _spawn_enemy()
		"boss": _spawn_boss()
		"dialog": _spawn_dialog()
		"endOfStage": _stage_end()

### spawn dialog
func _spawn_dialog():
	var new_dialog = Dialogic.start(currentWave.timeline)
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "_on_timeline_end")

func _on_timeline_end(_timeline):
	yield(get_tree().create_timer(1), "timeout")
	_next_wave()

### spawn boss
func _spawn_boss():
	#yield(get_tree().create_timer(3), "timeout")
	MySignals.emit_signal("stop_background")
	var new = currentWave.file.instance()
	add_child(new)

### spawn enemy
func _spawn_enemy():
	timerSpawn.start(currentWave.spawnTimer)
	var new = currentWave.file[Utils.rng.randi_range(0, currentWave.file.size() -1)].instance()
	new.global_position = _get_start_position()
	add_child(new)

func _get_start_position():
	var posX = Utils.rng.randi_range(currentWave.offsetX, Utils.window_width -currentWave.offsetX)
	var posY = -currentWave.offsetY
	return Vector2(posX, posY)

### end stage
func _stage_end():
	MySignals.emit_signal("end_stage", currentWave.wait_time)

########################################################################
### next wave
func _on_TimerWave_timeout(): _next_wave()

func _next_wave():
	if mission.size() <= 0:
		MySignals.emit_signal("end_stage", 1)
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
	currentWave = mission.pop_front()

func _start_next_wave():
	timerSpawn.start(currentWave.spawnTimer)
	if currentWave.type == "enemy":
		timerWave.start(currentWave.waveTime)

func _start_wave_background():
	if currentWave == ASTEROIDS: MySignals.emit_signal("asteroids_start")
	if currentWave == DEBRIS: MySignals.emit_signal("debris_start")
