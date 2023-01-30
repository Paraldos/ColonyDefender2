extends "res://enemies/Boss/Boss.gd"

#################################################
var MINI_EXPLOSION = preload("res://explosions/Explosion01.tscn")
var BIG_EXPLOSION = preload("res://explosions/Explosion05.tscn")
# nodes
onready var moveTimer = $MoveTimer
onready var deathTimer = $DeathTimer
onready var animDeath = $AnimDeath
onready var salvo = $Gun/Sprite/Salvo
onready var pulse = $Pulse
onready var gun = $Gun
# attacks
var attackCycle = 0
# movement
var window_width = Utils.window_width
var window_height = Utils.window_height
var targetPosition = Vector2.ZERO
const OFFSET = 62

#################################################
func _intro_done():
	moveTimer.start(0)

#################################################
func _on_MoveTimer_timeout():
	if !aktive: return
	targetPosition = _get_targetPosition()
	yield(_move(), "completed")
	_attack()
	moveTimer.start(1)

### move
func _move():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self,
		"global_position",
		targetPosition,
		1)
	yield(tween, "finished")

### target position
func _get_targetPosition():
	###
	var posX = Utils.rng.randi_range(OFFSET, window_width/2 -OFFSET)
	if global_position.x <= window_width/2: posX += window_width/2
	###
	var posY = Vector2.ZERO
	posY = Utils.rng.randi_range(OFFSET, window_height/2)
	###
	return Vector2(posX, posY)

### attack
func _attack():
	if !aktive: return
	match Utils.rng.randi_range(0, 1):
		0: 
			salvo.look_at(Utils.player_pos)
			salvo._attack(baseDmg)
		1: 
			for i in 3:
				pulse._attack(baseDmg)
				yield(get_tree().create_timer(0.2), "timeout")

#################################################
func _on_Hurtbox_hit(dmg):
	if !aktive: return
	if animHit.is_playing(): return
	###
	if dmg > 15: dmg = 15
	###
	Utils._dmg_label(dmg, global_position)
	animHit.play("hit")
	###
	hp -= dmg
	bossUi._update_hp(hp)
	_death()

func _on_Hitbox_area_entered(_area):
	if !aktive: return
	if animHit.is_playing(): return
	###
	animHit.play("hit")
	hp -= 10
	bossUi._update_hp(float(hp))
	_death()

func _death():
	if hp > 0: return
	MySignals.emit_signal("end_stage")
	_disable_everything()
	_mini_explosions()
	yield(_move_to_center_of_screen(), "completed")
	_big_explosion()
	queue_free()

### disable everything
func _disable_everything():
	aktive = false
	moveTimer.stop()
	gun._stop()
	salvo._stop()
	pulse._stop()

### mini explosions
func _mini_explosions():
	deathTimer.start(0.1)
	animDeath.play("loop")

func _on_DeathTimer_timeout():
	var new = MINI_EXPLOSION.instance()
	var offset = Vector2(Utils.rng.randi_range(-32, 32), Utils.rng.randi_range(-15, 15))
	new.global_position = global_position + offset
	new.scale = Vector2(1.3, 1.3)
	get_tree().current_scene.add_child(new)

### move to center
func _move_to_center_of_screen():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self,
		"global_position",
		Vector2(window_width/2, window_height/2 -20),
		2)
	yield(tween, "finished")
	yield(get_tree().create_timer(0.5), "timeout")

### big explosion
func _big_explosion():
	var new = BIG_EXPLOSION.instance()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)
