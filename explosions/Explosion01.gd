extends Sprite

onready var audio = $Audio

func _ready():
	audio.pitch_scale = Utils.rng.randf_range(0.80, 1.2)
