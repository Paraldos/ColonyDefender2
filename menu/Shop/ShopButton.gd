extends "res://theme/BtnTemplate.gd"

var id = "test"

func _ready():
	text = Utils._id_to_label(id)
	if Utils.player[id] >= MyDb.shop[id].max_level: 
		disabled = true

func _on_ShopButton_focus_entered():
	MySignals.emit_signal("shop_info", id)

func _on_ShopButton_pressed():
	if MyDb.shop[id].cost <= Utils.player.credits:
		_accept()
		Utils.player[id] += 1
		Utils.player.credits -= MyDb.shop[id].cost
		MySignals.emit_signal("shop_info", id)
		MySignals.emit_signal("credits_update")
		_ready()
	else:
		_denied()
