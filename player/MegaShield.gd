extends Sprite

onready var timer = $Timer
onready var animState = $AnimState

func _ready():
	timer.start(1)

func _on_Timer_timeout():
	animState.play("off")

func _deactivate():
	MySignals.emit_signal("megashield_off")
	queue_free()
