extends CanvasLayer

onready var audioAccept = $AudioAccept
onready var audioDenied = $AudioDenied
onready var shopInfo = $"%ShopInfo"
var start = true

#################################################
func _ready():
	start = false
	Utils.pause_posible = false

#################################################
func _update(dbEntry):
	MySignals.emit_signal("credits_update")
	_update_buttons()
	shopInfo._start(dbEntry)

func _update_buttons():
	pass

#################################################
func _on_ShopMenu_tree_exited():
	Utils.pause_posible = true

#################################################
### Next
func _on_BtnNext_pressed():
	Utils._next_level()
	SceneTransition.change_scene("res://world/World.tscn")

func _on_BtnNext_focus_entered():
	if start: return



