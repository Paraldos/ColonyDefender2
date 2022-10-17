extends KinematicBody2D

########################################################################
onready var animHit = $AnimHit
###
export var explosion = 2
###
var hp = 0
var dmg = 0
var credits = 0
###
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
func _on_Hitbox__area_entered(area):
	hp -= 1000000
	_death()

func _on_Hurtbox__hit(dmg):
	animHit.play("hit")
	hp -= dmg
	_death()

func _death():
	if exploding: return
	if hp <= 0:
		exploding = true
		call_deferred("_powerup")
		call_deferred("_credits")
		_explosion()
		queue_free()


const EXPLOSIONS = [
	null,
	preload("res://explosions/Explosion01.tscn"),
	preload("res://explosions/Explosion02.tscn"),
	preload("res://explosions/Explosion03.tscn"),
	preload("res://explosions/Explosion04.tscn")
]

func _explosion():
	var new = EXPLOSIONS[explosion].instance()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)

func _credits():
	#Utils.player.credits += credits
	#MySignals.emit_signal("credits_update")
	for i in credits:
		var new = preload("res://Powerup/Credits.tscn").instance()
		new.move_vector.x = Utils.rng.randf_range(-2, 2)
		new.move_vector.y = Utils.rng.randf_range(-2, 2)
		new.global_position = global_position
		get_tree().current_scene.add_child(new)

func _powerup():
	match Utils.rng.randi_range(0, 10):
		0:
			var new = preload("res://Powerup/Energy.tscn").instance()
			new.global_position = global_position
			get_tree().current_scene.add_child(new)
		1:
			var new = preload("res://Powerup/HP.tscn").instance()
			new.global_position = global_position
			get_tree().current_scene.add_child(new)




