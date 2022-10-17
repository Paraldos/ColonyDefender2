extends Node2D

var dmg = 0

func _ready():
	$Label.text = str(dmg)
	yield($Anim, "animation_finished")
	queue_free()
