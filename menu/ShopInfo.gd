extends VBoxContainer

onready var header = $Header
onready var cost = $Cost
onready var level = $Level
onready var description = $Description

func _ready():
	modulate = Color("00ffffff")
	MySignals.connect("update_shop_info", self, "_on_update_shop_info")

func _on_update_shop_info(dbEntry):
	modulate = Color("ffffff")
	header.text = Utils._id_to_label(dbEntry)
	cost.text = "Cost: " + String(MyDb.shop[dbEntry].cost)
	level.text = "Level: " + String(Utils.player[dbEntry])
	description.text = MyDb.shop[dbEntry].description

func _stop():
	modulate = Color("00ffffff")

