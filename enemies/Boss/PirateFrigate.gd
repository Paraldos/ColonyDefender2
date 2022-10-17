extends "res://enemies/Boss/Boss.gd"

var vulnerable = false
onready var bossUi = $BossUI

func _ready():
	_start()

func _start():
	global_position = Vector2(Utils.window_width/2, -60)
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,
		"global_position",
		global_position + Vector2(0, 150),
		2)
	###
	yield(tween, "finished")
	bossUi._start()
	###
	yield(get_tree().create_timer(1), "timeout")
	vulnerable = true
