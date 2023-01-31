extends CanvasLayer

onready var anim = $Anim
export var fade = true
export var aktivate_pause = true
export(float) var waitTime = 0

###########################################################
func _ready():
	yield(get_tree().create_timer(waitTime), "timeout")
	_start()

###########################################################
func _start():
	if aktivate_pause:
		MyPause._start()
	anim.play("start")

###########################################################
func _stop():
	if fade: anim.play("stop")

###########################################################
func _grab_focus():
	MySignals.emit_signal("grab_focus")

func _on_Menu_tree_exiting():
	MySignals.emit_signal("grab_focus")
	if aktivate_pause:
		MyPause._stop()
