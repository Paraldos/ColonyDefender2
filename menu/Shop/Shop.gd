extends "res://menu/Menu.gd"

onready var options = $"%Options"
onready var level = $"%Level"
onready var price = $"%Price"
onready var description = $"%Description"
var shopButton = preload("res://menu/Shop/ShopButton.tscn")

#################################################
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		_stop()

#################################################
func _ready():
	MySignals.connect("shop_info", self, "_on_shop_info")
	_clean_up_options()
	_fill_options()

#################################################
func _clean_up_options():
	for item in options.get_children():
		item.queue_free()

func _fill_options():
	for item in MyDb.shop:
		var new = shopButton.instance()
		new.id = item
		options.add_child(new)

#################################################
func _on_BtnExit_pressed():
	_stop()

#################################################
func _on_shop_info(id):
	level.text = "Level: %s" % Utils.player[id]
	price.text = "Price: %s" % MyDb.shop[id].cost
	description.text = MyDb.shop[id].description



