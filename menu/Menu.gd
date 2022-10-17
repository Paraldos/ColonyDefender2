extends CanvasLayer

onready var anim = $Anim
export var fade = true

###########################################################
func _ready():
	_start()

func _is_playing():
	return anim.is_playing()

func _start():
	get_tree().paused = true
	anim.play("start")

func _stop():
	get_tree().paused = false
	if fade: anim.play("stop")

func _grab_focus():
	MySignals.emit_signal("grab_focus")
