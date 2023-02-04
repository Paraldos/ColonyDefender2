extends Node2D

onready var timer = $Timer
var waves = []
var counter = 0

########################################################################
func _ready():
	MySignals.connect("boss_defeated", self, "_on_boss_defeated")
	waves = MyMissions.currentMission.waves.duplicate()
	timer.start(3)

### boss defeated
func _on_boss_defeated():
	waves.pop_front()
	timer.start(0.1)

########################################################################
func _input(_event):
	if Input.is_action_just_pressed("ui_pause"):
		if get_tree().get_nodes_in_group("menus").size() <= 0:
			Utils._open_pause()

########################################################################
func _on_Timer_timeout():
	if waves.size() <= 0:
		MySignals.emit_signal("initiate_warp_jump", 1)
	match waves[0].type:
		"particles": _particles()
		"dialog": _spawn_dialog()
		"boss": _spawn_boss()
		"enemy": _spawn_enemy()
		"endOfStage": _stage_end()

### particles
func _particles():
	MySignals.emit_signal("stop_background_particles")
	MySignals.emit_signal("start_background_particles", waves[0].background)
	waves.pop_front()
	timer.start(1)

### spawn dialog
func _spawn_dialog():
	var new_dialog = Dialogic.start(waves[0].timeline)
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "_on_timeline_end")

func _on_timeline_end(_timeline):
	waves.pop_front()
	timer.start(1)

### spawn boss
func _spawn_boss():
	yield(get_tree().create_timer(waves[0].timer), "timeout")
	var new = waves[0].file.instance()
	add_child(new)

### spawn enemy
func _spawn_enemy():
	###
	if counter <= 0:
		counter = waves[0].counter
	###
	var new = waves[0]._get_file().instance()
	new.global_position = waves[0]._get_start_position()
	add_child(new)
	###
	counter -= 1
	if counter <= 0: 
		waves.pop_front()
		timer.start(1)
	else:
		timer.start(waves[0].timer)

### end stage
func _stage_end():
	MySignals.emit_signal("initiate_warp_jump", waves[0].timer)



