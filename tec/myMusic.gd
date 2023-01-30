extends Node

onready var audio = $Audio
export var playMusic = true

const SONGS = [
	preload("res://music/Nihilore - Broken Parts - 04 The Water and the Well.mp3"),
	preload("res://music/Nihilore - Broken Parts - 06 Bush Week.mp3"),
	preload("res://music/Nihilore - Broken Parts - 07 Dissent.mp3"),
	preload("res://music/Nihilore - Broken Parts - 10 Walks of Life.mp3"),
	preload("res://music/Nihilore - Consequences EP - 03 Solipsism.mp3"),
	preload("res://music/Nihilore - The Hermeneutic Circle - 02 Whispers Invoke Paranoia.mp3"),
	preload("res://music/Nihilore - Truth and Justification - 05 In the Belly of the Whale.mp3"),
]

func _ready():
	if playMusic: _start_music()

func _on_Audio_finished():
	_start_music()

func _start_music():
	var song = Utils.rng.randi_range(0, SONGS.size() -1)
	audio.stream = SONGS[song]
	audio.play()
