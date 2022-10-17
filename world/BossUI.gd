extends CanvasLayer

onready var anim = $Anim
onready var nameLabel = $Name

func _ready():
	anim.play("RESET")

func _start(name):
	nameLabel.text = name
	anim.play("start")
