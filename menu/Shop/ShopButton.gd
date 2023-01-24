extends "res://theme/Button.gd"

var id = "test"

func _ready():
	labelText = Utils._id_to_label(id)
	_extended_update()

func _extended_update():
	_update()
	if Utils.player[id] >= MyDb.shop[id].max_level:
		_disable()

func _on_ShopButton_focus_entered():
	MySignals.emit_signal("shop_info", id)

func _on_ShopButton_pressed():
	if MyDb.shop[id].cost <= Utils.player.credits:
		audioAccept.play()
		Utils.player[id] += 1
		Utils.player.credits -= MyDb.shop[id].cost
		MySignals.emit_signal("shop_info", id)
		MySignals.emit_signal("credits_update")
		_extended_update()
	else:
		_denied()
