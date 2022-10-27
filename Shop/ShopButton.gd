extends "res://theme/Button.gd"

onready var audioAccept = $AudioAccept
onready var audioDenied = $AudioDenied
export var dbEntry = ""

#################################################
func _ready():
	labelText = Utils._id_to_label(dbEntry)
	label.text = labelText
	_update_button()


#################################################
func _buy_upgrade():
	if MyDb.shop[dbEntry].cost <= Utils.player.credits:
		Utils.player.credits -= MyDb.shop[dbEntry].cost
		Utils.player[dbEntry] += 1
		return true
	else:
		return false

#################################################
func _update():
	MySignals.emit_signal("credits_update")
	MySignals.emit_signal("update_shop_info", dbEntry)
	_update_button()

#################################################
func _update_button():
	if Utils.player[dbEntry] >= MyDb.shop[dbEntry].max_level:
		_disable()

#################################################
func _btn_sound(buy_attempt):
	if buy_attempt: audioAccept.play()
	else: audioDenied.play()

#################################################
func _on_ShopButton_pressed():
	_btn_sound(_buy_upgrade())
	_update()

func _on_ShopButton_focus_entered():
	_update()
