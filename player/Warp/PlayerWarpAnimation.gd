extends KinematicBody2D

var sprite = $Sprite

func _ready():
	pass # Replace with function body.

func _move_to_startposition():
	if global_position.x < Utils.window_width/2 -16:
		anim_stateMachine.travel("Right")
	elif global_position.x > Utils.window_width/2 +16:
		anim_stateMachine.travel("Left")
	else:
		anim_stateMachine.travel("Center")
	##########
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self,
		"global_position",
		Vector2(Utils.window_width/2, 210),
		1)
	yield(tween, "finished")
	##########
	anim_stateMachine.travel("Center")


