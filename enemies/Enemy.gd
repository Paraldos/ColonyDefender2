extends KinematicBody2D

########################################################################
onready var animHit = $AnimHit
export var explosion = 2
var hp = 0
var dmg = 0
var credits = 0
var powerups = [
	preload("res://Powerup/Energy.tscn"),
	preload("res://Powerup/HP.tscn")
]
var exploding = false

func _ready():
	_get_db_variables()

func _get_db_variables():
	hp = MyDb.enemies[_get_name()].hp
	dmg = MyDb.enemies[_get_name()].dmg
	credits = MyDb.enemies[_get_name()].credits

func _get_name():
	if name[0] != "@": return name
	return name.get_slice("@", 1)

########################################################################
func _on_VisibilityNotifier_screen_exited():
	queue_free()

########################################################################
func _on_Hitbox_area_entered(_area):
	hp -= 1000000
	_death()

func _on_Hurtbox_hit(dmg):
	if exploding: return
	Utils._dmg_label(dmg, global_position)
	animHit.play("hit")
	hp -= dmg
	_death()

func _death():
	if exploding: return
	if hp <= 0:
		exploding = true
		call_deferred("_powerup")
		call_deferred("_coins")
		_explosion()
		queue_free()

const EXPLOSIONS = [
	null,
	preload("res://explosions/Explosion01.tscn"),
	preload("res://explosions/Explosion02.tscn"),
	preload("res://explosions/Explosion03.tscn"),
	preload("res://explosions/Explosion04.tscn"),
	preload("res://explosions/Explosion05.tscn"),
]

func _explosion():
	var new = EXPLOSIONS[explosion].instance()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)

func _coins():
	for i in credits:
		var new = preload("res://Powerup/Coin.tscn").instance()
		new.move_vector.x = Utils.rng.randf_range(-2, 2)
		new.move_vector.y = Utils.rng.randf_range(-2, 2)
		new.global_position = global_position
		get_tree().current_scene.add_child(new)

func _powerup():
	if Utils.rng.randi_range(1, 10) >= 2:
		var myNr = Utils.rng.randi_range(0, powerups.size() -1)
		var new = powerups[myNr].instance()
		new.global_position = global_position
		get_tree().current_scene.add_child(new)







