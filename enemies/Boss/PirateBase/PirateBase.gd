extends Node2D

onready var bossUi = $BossUI
onready var body = $Body
onready var animHit = $Body/AnimHit
onready var TimerMiniExplosions = $Body/TimerMiniExplosions
onready var posBigExplosion = $Body/PosBigExplosion
onready var animDeath = $Body/AnimDeath
onready var posDmg = $Body/PosDmg
var MINI_EXPLOSION = preload("res://explosions/Explosion01.tscn")
var BIG_EXPLOSION = preload("res://explosions/Explosion05.tscn")
var window_width = Utils.window_width
var window_height = Utils.window_height
var introSpeed = 1.5
var hp = 5
var aktive = false

#################################################
func _ready():
	MySignals.emit_signal("start_background_particles", "Asteroids")
	yield(get_tree().create_timer(2), "timeout")
	yield(_move_onto_screen(), "completed")
	yield(_start_ui(), "completed")
	aktive = true

func _move_onto_screen():
	var tween = create_tween()
	tween.tween_property(
		body,
		"position",
		Vector2.ZERO,
		introSpeed)
	yield(tween, "finished")

func _start_ui():
	bossUi._start(hp)
	yield(get_tree().create_timer(1), "timeout")

#################################################
func _on_Hurtbox_hit(dmg):
	if !aktive: return
	if animHit.is_playing(): return
	############################
	Utils._dmg_label(dmg, posDmg.position)
	animHit.play("hit")
	############################
	if dmg > 15: dmg = 15
	hp -= dmg
	bossUi._update_hp(hp)
	_death()

func _death():
	if hp > 0: return
	############################
	_disable_everything()
	MySignals.emit_signal("boss_defeated")
	TimerMiniExplosions.start()
	yield(get_tree().create_timer(2), "timeout")
	TimerMiniExplosions.stop()
	_big_explosion()
	animDeath.play("death")

func _disable_everything():
	aktive = false

### mini explosions
func _on_TimerMiniExplosions_timeout():
	for i in 3:
		_mini_explosion()

func _mini_explosion():
	var new = MINI_EXPLOSION.instance()
	############################
	var offsetX = Utils.rng.randi_range(16, window_width-16)
	var offsetY = Utils.rng.randi_range(16, 80)
	new.global_position = Vector2(offsetX, offsetY)
	############################
	var scaleOffset = Utils.rng.randi_range(0.8, 1.2)
	new.scale = Vector2(scaleOffset, scaleOffset)
	############################
	new.rotation_degrees = Utils.rng.randi_range(0, 45)
	############################
	get_tree().current_scene.add_child(new)

func _big_explosion():
	var new = BIG_EXPLOSION.instance()
	new.global_position = posBigExplosion.global_position
	get_tree().current_scene.add_child(new)


