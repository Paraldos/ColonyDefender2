extends Node2D

#################################################
onready var body = $Body
onready var animHit = $Body/AnimHit
onready var bossUi = $BossUI
onready var moveTimer = $Body/MoveTimer
onready var TimerMiniExplosions = $Body/TimerMiniExplosions
onready var gun = $Body/Gun
onready var pulse = $Body/Pulse
onready var salvo = $Body/Gun/Salvo
onready var posExplosions = $Body/PosExplosions

var MINI_EXPLOSION = preload("res://explosions/Explosion01.tscn")
var BIG_EXPLOSION = preload("res://explosions/Explosion05.tscn")

export var hp = 100
export var dmg = 2
var introSpeed = 1.5
var aktive = false
var attackCycle = 0
var window_width = Utils.window_width
var window_height = Utils.window_height

#################################################
func _ready():
	body.global_position.x = window_width / 2
	yield(_move_onto_screen(), "completed")
	yield(_start_ui(), "completed")
	aktive = true
	moveTimer.start()

func _move_onto_screen():
	var tween = create_tween()
	tween.tween_property(
		body,
		"position",
		Vector2(window_width / 2, 80),
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
		body,
		"position",
		_get_target_position(),
		1)
	yield(tween, "finished")

func _get_target_position():
	var OFFSET = 62
	var POSX = Vector2.ZERO
	if body.position.x >= window_width/2:
		POSX = Utils.rng.randi_range(OFFSET, window_width/2 -OFFSET)
	else:
		POSX = Utils.rng.randi_range(window_width/2 +OFFSET, window_width -OFFSET)
	###
	var POSY = Utils.rng.randi_range(OFFSET, window_height/2)
	###
	return Vector2(POSX, POSY)

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
	Utils._dmg_label(dmg, body.position)
	animHit.play("hit")
	###
	if dmg > 15: dmg = 15
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
	############################
	_disable_everything()
	MySignals.emit_signal("boss_defeated")
	TimerMiniExplosions.start()
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
func _on_TimerMiniExplosions_timeout():
	for i in 2:
		_mini_explosion()

func _mini_explosion():
	var new = MINI_EXPLOSION.instance()
	############################
	var offsetX = Utils.rng.randi_range(-32, 32)
	var offsetY = Utils.rng.randi_range(-32, 32)
	new.global_position = posExplosions.global_position + Vector2(offsetX, offsetY)
	############################
	var scaleOffset = Utils.rng.randi_range(0.8, 1.2)
	new.scale = Vector2(scaleOffset, scaleOffset)
	############################
	get_tree().current_scene.add_child(new)

### move to center
func _move_to_center_of_screen():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		body,
		"position",
		Vector2(window_width/2, window_height/2 -20),
		2)
	yield(tween, "finished")
	yield(get_tree().create_timer(0.5), "timeout")

### big explosion
func _big_explosion():
	var new = BIG_EXPLOSION.instance()
	new.global_position = posExplosions.global_position
	get_tree().current_scene.add_child(new)


