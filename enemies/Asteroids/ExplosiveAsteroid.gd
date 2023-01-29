extends "res://enemies/Asteroids/Asteroid.gd"

var blast = preload("res://enemies/Asteroids/ExplosiveAsteroidBlast.tscn")

func _death():
	if exploding: return
	if hp <= 0:
		exploding = true
		call_deferred("_powerup")
		call_deferred("_coins")
		call_deferred("_explosion")
		call_deferred("_instance_blast")
		queue_free()

func _instance_blast():
	var new = blast.instance()
	new.dmg = dmg
	new.global_position = global_position
	new.scale = scale
	get_tree().current_scene.add_child(new)




