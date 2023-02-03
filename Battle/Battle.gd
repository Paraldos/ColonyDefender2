extends Node2D

onready var timerWave = $TimerWave
onready var timerSpawn = $TimerSpawn
var waves = []
var currentWave = {}

########################################################################
func _ready():
	MySignals.connect("boss_defeated", self, "_on_boss_defeated")
	timerWave.start(3)
	waves = MyMissions.currentMission.waves

########################################################################
func _input(_event):
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
	MySignals.emit_signal("stop_background")
	var new = currentWave.file.instance()
	add_child(new)

### spawn enemy
func _spawn_enemy():
	timerSpawn.start(currentWave.spawnTimer)
	var new = currentWave._get_file().instance()
	new.global_position = currentWave._get_start_position()
	add_child(new)

### end stage
func _stage_end():
	MySignals.emit_signal("initiate_warp_jump", currentWave.wait_time)

########################################################################
### next wave
func _on_TimerWave_timeout(): _next_wave()
func _on_boss_defeated(): _next_wave()

func _next_wave():
	if waves.size() <= 0:
		MySignals.emit_signal("initiate_warp_jump", 1)
	else:
		timerSpawn.stop()
		MySignals.emit_signal("stop_background_particles")
		currentWave = waves.pop_front()
		_start_next_wave()
		_start_background()

func _start_next_wave():
	timerSpawn.start(currentWave.spawnTimer)
	if currentWave.type == "enemy":
		timerWave.start(currentWave.waveTime)

func _start_background():
	if currentWave.type == "enemy":
			currentWave._start_background()

