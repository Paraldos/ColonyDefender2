extends Node

var enemies = {}
var shop = {}

func _ready():
	_enemies()
	_shop()

#################################################
### enemies
func _enemies():
	var file = _load_csv("res://Tec/enemies.csv")
	var keys = _get_keys(file)
	file.remove(0)
	for el in file:
		enemies[el[keys.id]] = {
			id = el[keys.id],
			hp = int(el[keys.hp]),
			dmg = int(el[keys.dmg]),
			credits = int(el[keys.credits])
		}

### shop
func _shop():
	var file = _load_csv("res://Tec/shop.csv")
	var keys = _get_keys(file)
	file.remove(0)
	for el in file:
		shop[el[keys.id]] = {
			id = el[keys.id],
			cost = int(el[keys.cost]),
			description = el[keys.description],
			max_level = int(el[keys.max_level])
		}

#################################################
### helper
func _load_csv(path):
	var file = File.new()
	file.open(path, file.READ)
	###
	var result = []
	while !file.eof_reached():
		var csv_line = file.get_csv_line(";")
		result.push_back(csv_line)
	#result.remove(0)
	result.remove(result.size()-1)
	###
	file.close()
	return result

func _get_keys(file):
	var keys = {}
	for index in file[0].size():
		keys[file[0][index]] = index
	return keys
