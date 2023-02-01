extends CanvasLayer

onready var anim = $Anim
export var fade = true
export var aktivate_pause = true

###########################################################
func _ready():
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
