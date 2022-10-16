extends Node

onready var audio = $Audio

func _ready():
	_start_music()

func _on_Audio_finished():
	_start_music()

func _start_music():
	var song = Utils.rng.randi_range(0, MyPreload.SONGS.size() -1)
	audio.stream = MyPreload.SONGS[song]
	audio.play()
