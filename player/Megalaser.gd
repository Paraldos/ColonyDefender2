extends Position2D

#################################################
onready var TIMER = $Timer
onready var ANIM = $Anim
onready var HITBOX = $Hitbox

#################################################
func _ready():
	TIMER.start(0.5)
	HITBOX.dmg = Utils.player.megalaser_dmg

#################################################
func _on_Timer_timeout():
	ANIM.play("off")

func _deactivate():
	MySignals.emit_signal("megalaser_off")
	queue_free()
