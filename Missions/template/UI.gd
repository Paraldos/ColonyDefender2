extends CanvasLayer

onready var anim = $Anim

func _ready():
	MySignals.connect("stop_ui", self, "_stop")

func _stop():
	anim.play_backwards("start")
