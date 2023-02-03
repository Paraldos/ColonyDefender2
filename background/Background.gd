extends CanvasLayer

onready var Particles_Debris = $BackgroundParticlesDebris
onready var Particles_Asteroids = $BackgroundParticlesAsteroids
const BACKGROUND_TEXTURES = [
	preload("res://img/Space_01-Sheet.png"),
	preload("res://img/Space_02-Sheet.png"),
	preload("res://img/Space_03-Sheet.png"),
	preload("res://img/Space_04-Sheet.png")
]
onready var ParalaxBackground = $"%ParallaxBackground"
onready var sprite01 = $ParallaxBackground/ParallaxLayer/Sprite
onready var sprite02 = $ParallaxBackground/ParallaxLayer2/Sprite
onready var sprite03 = $ParallaxBackground/ParallaxLayer3/Sprite
onready var sprite04 = $ParallaxBackground/ParallaxLayer4/Sprite
onready var sprite05 = $ParallaxBackground/ParallaxLayer5/Sprite

export var SPEED = Vector2(0.0, 1.0)

########################################################################
func _ready():
	MySignals.connect("start_background_particles", self, "_on_start_background_particles")
	MySignals.connect("stop_background_particles", self, "_on_stop_background_particles")
	MySignals.connect("stop_background", self, "_on_stop_background")
	MySignals.connect("start_background", self, "_on_start_background")
	_randomize_background()

########################################################################
func _physics_process(_delta):
	var i = 1
	for layer in ParalaxBackground.get_children():
		layer.motion_offset.y += SPEED.y * i
		layer.motion_offset.x += SPEED.x * i
		i += 0.1

########################################################################
### particles
func _on_start_background_particles(name):
	if name == "Debris":
		Particles_Debris.emitting = true
	if name == "Asteroids":
		Particles_Asteroids.emitting = true

func _on_stop_background_particles():
	Particles_Debris.emitting = false
	Particles_Asteroids.emitting = false

########################################################################
### paralax background
func _randomize_background():
	var backgroundNr = Utils.rng.randi_range(0, BACKGROUND_TEXTURES.size()-1)
	sprite01.texture = BACKGROUND_TEXTURES[backgroundNr]
	sprite02.texture = BACKGROUND_TEXTURES[backgroundNr]
	sprite03.texture = BACKGROUND_TEXTURES[backgroundNr]
	sprite04.texture = BACKGROUND_TEXTURES[backgroundNr]
	sprite05.texture = BACKGROUND_TEXTURES[backgroundNr]

func _on_start_background(x, y):
	var tween = create_tween()
	tween.tween_property(
		self,
		"SPEED",
		Vector2(x,y),
		6)

func _on_stop_background():
	var tween = create_tween()
	tween.tween_property(
		self,
		"SPEED",
		Vector2(0,0),
		6)

