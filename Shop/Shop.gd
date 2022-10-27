extends CanvasLayer

onready var hangar_anim = $Hangar/Anim

func _ready():
	hangar_anim.play_backwards("open")


func _on_BtnNextStage_pressed():
	Utils._next_stage()
	SceneTransition.change_scene("res://world/World.tscn")

