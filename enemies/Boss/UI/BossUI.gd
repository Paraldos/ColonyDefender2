extends CanvasLayer

onready var anim = $Anim
onready var over = $Health/Over
onready var under = $Health/Under

#################################################
func _ready():
	MySignals.connect("stop_ui", self, "_stop")
	anim.play("RESET")

func _stop():
	anim.play_backwards("start")

#################################################
func _start(hp_max):
	anim.play("start")
	_update_max(hp_max)

func _update_max(value):
	over.max_value = value
	over.value = value
	under.max_value = value
	under.value = value

func _update_hp(newValue):
	newValue = float(newValue)
	over.value = newValue
	var tween = create_tween()
	tween.tween_property(under, "value", newValue,  0.5)
