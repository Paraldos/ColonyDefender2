extends ParallaxBackground

const BACKGROUND_TEXTURES = [
	preload("res://img/Space_01-Sheet.png"),
	preload("res://img/Space_02-Sheet.png"),
	preload("res://img/Space_03-Sheet.png"),
	preload("res://img/Space_04-Sheet.png")
]



onready var sprite01 = $ParallaxLayer/Sprite
onready var sprite02 = $ParallaxLayer2/Sprite
onready var sprite03 = $ParallaxLayer3/Sprite
onready var sprite04 = $ParallaxLayer4/Sprite
onready var sprite05 = $ParallaxLayer5/Sprite

export var SPEED_Y = 1.0
export var SPEED_X = 0.0

func _ready():
# warning-ignore:return_value_discarded
	MySignals.connect("stop_background", self, "_on_stop_background")
	_randomize_background()

func _on_stop_background():
	var tween = create_tween()
	tween.tween_property(
		self,
		"SPEED_Y",
		0.0,
		6)
	var tween2 = create_tween()
	tween2.tween_property(
		self,
		"SPEED_X",
		0.0,
		6)

func _randomize_background():
	var backgroundNr = Utils.rng.randi_range(0, BACKGROUND_TEXTURES.size()-1)
	sprite01.texture = BACKGROUND_TEXTURES[backgroundNr]
	sprite02.texture = BACKGROUND_TEXTURES[backgroundNr]
	sprite03.texture = BACKGROUND_TEXTURES[backgroundNr]
	sprite04.texture = BACKGROUND_TEXTURES[backgroundNr]
	sprite05.texture = BACKGROUND_TEXTURES[backgroundNr]

func _physics_process(_delta):
	var i = 1
	for layer in get_children():
		layer.motion_offset.y += SPEED_Y * i
		layer.motion_offset.x += SPEED_X * i
		i += 0.1
