extends KinematicBody2D

#################################################
### nodes
onready var anim_stateMachine = $AnimTree.get("parameters/playback")
onready var gunController = $GunController
onready var bombController = $BombController
onready var laserController = $LaserController
onready var shieldController = $ShieldController
onready var sprite = $Sprite
onready var deathTimer = $DeathTimer
onready var audioDeath = $AudioDeath
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
var megashield = false

#################################################
func _ready():
# warning-ignore:return_value_discarded
	MySignals.connect("megashield_on", self, "_on_megashield_on")
# warning-ignore:return_value_discarded
	MySignals.connect("megashield_off", self, "_on_megashield_off")

func _on_megashield_on():
	megashield = true

func _on_megashield_off():
	megashield = false

#################################################
func _physics_process(delta):
	Utils.player_pos = global_position
	if Utils.player.hp <= 0:
		_death()
	else:
		if Input.is_action_just_pressed("ui_selfdestruction"):
			Utils.player.hp = 0
			audioDeath.play()
			deathTimer.start()
		_move(delta)
		_animation()
		gunController._attack()
		bombController._megabomb()
		laserController._megalaser()
		shieldController._megashield()

##### death
func _death():
	var x = 1
	sprite.offset.x = Utils.rng.randf_range(-x, x)
	sprite.offset.y = Utils.rng.randf_range(-x, x)

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
func _on_Hurtbox__hit(dmg):
	if Utils.player.hp <= 0: return
	if megashield: return
	###
	Utils.player.hp -= dmg
	MySignals.emit_signal("hp_update")
	###
	if Utils.player.hp <= 0:
		audioDeath.play()
		deathTimer.start()


const EXPLOSION = preload("res://explosions/Explosion03.tscn")

func _on_DeathTimer_timeout():
	var newExplosion = EXPLOSION.instance()
	newExplosion.global_position = global_position
	get_tree().current_scene.add_child(newExplosion)
	###
	Utils._gameover()
	###
	queue_free()

