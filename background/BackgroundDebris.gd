extends Particles2D

func _ready():
	emitting = false
	MySignals.connect("debris_start", self, "_on_debris_start")
	MySignals.connect("debris_stop", self, "_on_debris_stop")

func _on_debris_start():
	emitting = true

func _on_debris_stop():
	emitting = false
