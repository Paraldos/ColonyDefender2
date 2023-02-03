extends Node2D

#################################################
onready var animHit = $Body/AnimHit
onready var bossUi = $BossUI
onready var moveTimer = $Body/MoveTimer
onready var deathTimer = $Body/DeathTimer
onready var gun = $Body/Gun
onready var pulse = $Body/Pulse
onready var salvo = $Body/Gun/Salvo
onready var posExplosions = $Body/PosExplosions

var MINI_EXPLOSION = preload("res://explosions/Explosion01.tscn")
var BIG_EXPLOSION = preload("res://explosions/Explosion05.tscn")

const OFFSET = 62
export var hp = 100
export var dmg = 2
var introSpeed = 1.5
var aktive = false
var attackCycle = 0
var window_width = Utils.window_width
var window_height = Utils.window_height

#################################################
func _ready():
	global_position.x = Utils.window_width / 2
	yield(_move_onto_screen(), "completed")
	yield(_start_ui(), "completed")
	aktive = true
	moveTimer.start()

func _move_onto_screen():
	var tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		Vector2(Utils.window_width / 2, 120),
		introSpeed)
	yield(tween, "finished")

func _start_ui():
	bossUi._start(hp)
	yield(get_tree().create_timer(1), "timeout")

#################################################
### default behaviour
func _on_MoveTimer_timeout():
	if !aktive: return
	yield(_move(), "completed")
	_attack()
	moveTimer.start()

func _move():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self,
		"global_position",
		_get_target_position(),
		1)
	yield(tween, "finished")

func _get_target_position():
	###
	var posX = Utils.rng.randi_range(OFFSET, window_width/2 -OFFSET)
	if global_position.x <= window_width/2: posX += window_width/2
	###
	var posY = Vector2.ZERO
	posY = Utils.rng.randi_range(OFFSET, window_height/2)
	###
	return Vector2(posX, posY)

func _attack():
	if !aktive: return
	match Utils.rng.randi_range(0, 1):
		0: 
			salvo.look_at(Utils.player_pos)
			salvo._attack(dmg)
		1: 
			for i in 3:
				pulse._attack(dmg)
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
	_disable_everything()
	MySignals.emit_signal("boss_defeated")
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

func _on_DeathTimer_timeout():
	var new = MINI_EXPLOSION.instance()
	var offset = Vector2(Utils.rng.randi_range(-32, 32), Utils.rng.randi_range(-32, 32))
	new.global_position = posExplosions.global_position + offset
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
	new.global_position = posExplosions.global_position
	get_tree().current_scene.add_child(new)

