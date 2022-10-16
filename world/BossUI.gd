extends CanvasLayer

onready var anim = $Anim

func _ready():
	anim.play("RESET")

func _start():
	anim.play("start")
