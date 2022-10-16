extends Node2D

onready var timerWave = $TimerWave
onready var timerSpawn = $TimerSpawn
var wavePause = 3
var wave = "pause"
var wavesToBoss = 10

########################################################################
func _ready():
	timerWave.start(wavePause)

########################################################################
func _physics_process(_delta):
	if !timerSpawn.is_stopped(): return
	match wave:
		"pause": return
		"asteroids": _spawn_asteroid()
		"fighters1": _spawn_fighter1()
		"fighters2": _spawn_fighter2()
		"gunships": _spawn_gunships()
		"missiles": _spawn_missiles()

func _spawn_asteroid():
	timerSpawn.start(0.8)
	var asteroidNr = Utils.rng.randi_range(0, MyPreload.ASTEROIDS.size() -1)
	var new = MyPreload.ASTEROIDS[asteroidNr].instance()
	new.global_position = _start_position()
	add_child(new)

func _spawn_fighter1():
	timerSpawn.start(0.6)
	var new = MyPreload.FIGHTER01.instance()
	new.global_position = _start_position()
	add_child(new)

func _spawn_fighter2():
	timerSpawn.start(0.6)
	var new = MyPreload.FIGHTER02.instance()
	new.global_position = _start_position()
	add_child(new)

func _spawn_gunships():
	timerSpawn.start(1.2)
	var new = MyPreload.GUNSHIP.instance()
	new.global_position = _start_position(40, 30)
	add_child(new)

func _spawn_missiles():
	timerSpawn.start(0.5)
	var new = MyPreload.MISSILE.instance()
	new.global_position = _start_position(20, 30)
	add_child(new)

func _start_position(marginSides = 20, margin_top = 20):
	var posX = Utils.rng.randi_range(marginSides, Utils.window_width -marginSides)
	var posY = -margin_top
	return Vector2(posX, posY)

########################################################################
func _on_TimerWave_timeout():
	MySignals.emit_signal("asteroids_stop")
	timerSpawn.stop()
	if Utils.wave >= wavesToBoss:
		wave = "Boss"
		MySignals.emit_signal("stop_background")
	elif wave == "pause":
		match Utils.rng.randi_range(0, 4):
			0:_fighter1(10)
			1: _fighter2(10)
			2: _asteroids(20)
			3: _gunships(8)
			4: _missiles(8)
		Utils.wave += 1
	else:
		wave = "pause"
		timerWave.start(wavePause)

func _fighter1(duration):
	wave = "fighters1"
	timerWave.start(duration)

func _fighter2(duration):
	wave = "fighters2"
	timerWave.start(duration)

func _asteroids(duration):
	wave = "asteroids"
	MySignals.emit_signal("asteroids_start")
	timerWave.start(duration)

func _gunships(duration):
	wave = "gunships"
	timerWave.start(duration)

func _missiles(duration):
	wave = "missiles"
	timerWave.start(duration)

