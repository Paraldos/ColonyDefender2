extends "res://enemies/Boss/Boss.gd"

#################################################
const PROJECTILE = preload("res://projectile/Projectile03.tscn")
# nodes
onready var bossUi = $BossUI
onready var moveTimer = $MoveTimer
onready var muzzle = $PositionMuzzle
# other
var dmg = 5
var vulnerable = false
var state = "intro"
# movement
var window_width = Utils.window_width
var window_height = Utils.window_height
var targetPosition = Vector2.ZERO
const OFFSET = 62

#################################################
func _ready():
	global_position = Vector2(Utils.window_width / 2, -20)
	targetPosition = _get_targetPosition()
	###
	var tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		Vector2(Utils.window_width / 2, 90),
		1)
	yield(tween, "finished")
	###
	bossUi._start("Pirate Frigate")
	yield(get_tree().create_timer(1), "timeout")
	###
	vulnerable = true
	state = "test"
	moveTimer.start(0)

#################################################
func _physics_process(delta):
	if state == "intro": return
	match state:
		"test": pass

#################################################
func _on_MoveTimer_timeout():
	targetPosition = _get_targetPosition()
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self,
		"global_position",
		targetPosition,
		1)
	yield(tween, "finished")
	_attack()
	moveTimer.start(1)

func _get_targetPosition():
	###
	var posX = Utils.rng.randi_range(OFFSET, window_width/2 -OFFSET)
	if global_position.x <= window_width/2: posX += window_width/2
	###
	var posY = Vector2.ZERO
	posY = Utils.rng.randi_range(OFFSET, window_height/2)
	###
	return Vector2(posX, posY)

func _attack():
	match Utils.rng.randi_range(0, 0):
		0: _salvo()
		1: pass

func _salvo():
	print("hi")
	var new = PROJECTILE.instance()
	new.global_position = muzzle.global_position
	new.velocity = Vector2(0, 0)
	new.dmg = dmg
	get_tree().current_scene.add_child(new)










