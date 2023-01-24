extends Particles2D

func _ready():
	emitting = false
	MySignals.connect("asteroids_start", self, "_on_asteroids_start")
	MySignals.connect("asteroids_stop", self, "_on_asteroids_stop")

func _on_asteroids_start():
	emitting = true

func _on_asteroids_stop():
	emitting = false
