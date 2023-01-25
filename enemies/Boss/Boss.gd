extends Node2D

#################################################
# nodes
onready var animHit = $AnimHit
onready var bossUi = $BossUI
# export variables
export var name_of_Boss = ""
export var hp = 100
export var baseDmg = 5
# other
var introSpeed = 1.5
var aktive = false

#################################################
func _ready():
	_start_position()
	yield(_move_onto_screen(), "completed")
	yield(_start_ui(), "completed")
	aktive = true
	_intro_done()

func _start_position():
	global_position = Vector2(Utils.window_width / 2, -40)

func _move_onto_screen():
	var tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		Vector2(Utils.window_width / 2, 90),
		introSpeed)
	yield(tween, "finished")

func _start_ui():
	bossUi._start(name_of_Boss, hp)
	yield(get_tree().create_timer(1), "timeout")

func _intro_done():
	pass
