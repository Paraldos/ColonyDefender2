extends Node

onready var audio = $Audio

const SONGS = [
	preload("res://music/laserattack.wav"),
	preload("res://music/Laser Quest Loop.wav"),
	preload("res://music/The Synths Loop.wav"),
]

func _ready():
	_start_music()

func _on_Audio_finished():
	_start_music()

func _start_music():
	var song = Utils.rng.randi_range(0, SONGS.size() -1)
	audio.stream = SONGS[song]
	audio.play()
