extends CanvasLayer

onready var anim = $Anim
export var fade = true
export var aktivate_pause = true

###########################################################
func _ready():
	Utils.pause_posible = false
	_start()

###########################################################
func _is_playing():
	return anim.is_playing()

###########################################################
func _start():
	if aktivate_pause:
		get_tree().paused = true
	anim.play("start")

###########################################################
func _stop():
	get_tree().paused = false
	if fade: anim.play("stop")

###########################################################
func _grab_focus():
	MySignals.emit_signal("grab_focus")

###########################################################
func _on_Menu_tree_exited():
	Utils.pause_posible = true
