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
	Utils.missionStats.credits.level += credits *50
	Utils.missionStats.enemies.level += 1

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

func _on_Hurtbox_hit(damage):
	if exploding: return
	Utils._dmg_label(damage, global_position)
	animHit.play("hit")
	hp -= damage
	_death()

func _death():
	if exploding: return
	if hp <= 0:
		Utils.missionStats.enemies.player += 1
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
	preload("res://explosions/Explosion05.tscn"),
]

func _explosion():
	var new = EXPLOSIONS[explosion].instance()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)

func _coins():
	for i in credits:
		MyLoot._spawn_coins(global_position)

func _powerup():
	MyLoot._spawn_powerup(global_position)




