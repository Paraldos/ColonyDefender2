extends KinematicBody2D

#################################################
### nodes
onready var anim_stateMachine = $AnimTree.get("parameters/playback")
onready var gunController = $GunController
onready var bombController = $BombController
onready var laserController = $LaserController
onready var shieldController = $ShieldController
onready var warpdrive = $Warpdrive
onready var sprite = $Sprite
onready var deathTimer = $DeathTimer
onready var audioDeath = $AudioDeath
onready var animHit = $AnimHit
### movement
const ACCELERATION = 1800
const MAX_SPEED = 400
const FRICTION = 0.3
var input_vector = Vector2.ZERO
var motion = Vector2.ZERO
### animation
var light_tilt = 0.2
var hard_tilt = 0.8
### other
const EXPLOSION = preload("res://explosions/Explosion05.tscn")
var megashield = false
var player_disabled = false

#################################################
func _ready():
	MySignals.connect("megashield_on", self, "_on_megashield_on")
	MySignals.connect("megashield_off", self, "_on_megashield_off")
	MySignals.connect("initiate_warp_jump", self, "_on_initiate_warp_jump")
	Utils.player_node = self

#################################################
func _physics_process(delta):
	Utils.player_pos = global_position
	if Utils.player.hp <= 0: _death_shacke()
	###
	if player_disabled: return
	else:
		if Input.is_action_just_pressed("ui_selfdestruction"):
			_on_Hurtbox_hit(Utils.player.hp)
		_move(delta)
		_animation()
		gunController._attack()
		bombController._megabomb()
		laserController._megalaser()
		shieldController._megashield()

#################################################
##### megashield
func _on_megashield_on():
	megashield = true

func _on_megashield_off():
	megashield = false

#################################################
##### movement
func _move(delta):
	_get_input()
	_set_motion(delta)
	_friction()
	motion = move_and_slide(motion)

func _get_input():
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

func _set_motion(delta):
	motion.x += input_vector.x * ACCELERATION * delta
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	motion.y += input_vector.y * ACCELERATION * delta
	motion.y = clamp(motion.y, -MAX_SPEED, MAX_SPEED)

func _friction():
	if input_vector.x == 0:
		motion.x = lerp(motion.x, 0, FRICTION)
	if input_vector.y == 0:
		motion.y = lerp(motion.y, 0, FRICTION)

##### animation
func _animation():
	var x = input_vector.x
	if x > light_tilt:
		anim_stateMachine.travel("Right")
		if x > hard_tilt:
			 anim_stateMachine.travel("HardRight")
	elif x < -light_tilt:
		anim_stateMachine.travel("Left")
		if x < -hard_tilt:
			anim_stateMachine.travel("HardLeft")
	else:
		anim_stateMachine.travel("Center")

#################################################
### getting hit and player death
func _on_Hurtbox_hit(dmg):
	if animHit.is_playing(): return
	if player_disabled: return
	if megashield: return
	###
	animHit.play("start")
	Utils.player.hp -= dmg
	Utils._dmg_label(dmg, global_position)
	MySignals.emit_signal("hp_update")
	###
	if Utils.player.hp <= 0:
		player_disabled = true
		audioDeath.play()
		deathTimer.start()

func _on_DeathTimer_timeout():
	var newExplosion = EXPLOSION.instance()
	newExplosion.global_position = global_position
	newExplosion.scale = Vector2(0.7, 0.7)
	get_tree().current_scene.add_child(newExplosion)
	###
	Utils._open_gameover()
	###
	queue_free()

func _death_shacke():
	var offset = 2
	sprite.offset.x = Utils.rng.randf_range(-offset, offset)
	sprite.offset.y = Utils.rng.randf_range(-offset, offset)

#################################################
### leave level
func _on_initiate_warp_jump(wait_time):
	### disable player controlls and hurtbox
	player_disabled = true
	### fade out UI
	MySignals.emit_signal("stop_ui")
	### move to start position
	yield(_move_to_startposition(), "completed")
	MySignals.emit_signal("start_background", 0, -0.5)
	### Warpdrive
	yield(get_tree().create_timer(wait_time), "timeout")
	warpdrive._start()

func _move_to_startposition():
	### adjust player animation to fit movement
	if global_position.x < Utils.window_width/2 -16:
		anim_stateMachine.travel("Right")
	elif global_position.x > Utils.window_width/2 +16:
		anim_stateMachine.travel("Left")
	else:
		anim_stateMachine.travel("Center")
	### move player
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self,
		"global_position",
		Vector2(Utils.window_width/2, 210),
		1)
	yield(tween, "finished")
	### reset player animation to default
	anim_stateMachine.travel("Center")

func _on_Warpdrive_warp_done():
	# open stage cleared screan after player has left the screan
	Utils._open_stage_cleared()
	queue_free()
