extends Sprite

onready var audio = $Audio

func _ready():
	rotation_degrees = Utils.rng.randi_range(0, 360)
	#var size = Utils.rng.randf_range(0.8, 1.2)
	#scale.x = size
	#scale.y = size
	audio.pitch_scale = Utils.rng.randf_range(0.90, 1.1)
	audio.volume_db = Utils.rng.randf_range(3, 6)
