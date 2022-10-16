extends Control

###########################################################
onready var control = $Control
onready var crline = $Control/CR_Line
onready var frame = $Control/Frame
var animationSpeed = 0.2
var open = false
signal open()
signal closed()

###########################################################
func _ready():
	control.modulate = Color("00ffffff")
	frame.modulate = Color("00ffffff")

###########################################################
func _start():
	if open: return
	##################
	control.modulate = Color("ffffff")
	frame.modulate = Color("00ffffff")
	##################
	control.rect_size = Vector2(2,2)
	control.rect_position = rect_size /2
	##################
	_control_size(Vector2(rect_size.x, 2))
	_control_position(Vector2(0, rect_size.y/2))
	##################
	yield(get_tree().create_timer(animationSpeed), "timeout")
	##################
	_control_size(rect_size)
	_control_position(Vector2.ZERO)
	##################
	_crline_color(Color("00ffffff"))
	_frame_color(Color("ffffff"))
	##################
	yield(get_tree().create_timer(animationSpeed), "timeout")
	##################
	open = true
	emit_signal("open")

func _stop():
	if !open: return
	##################
	control.modulate = Color("ffffff")
	crline.modulate = Color("ffffff")
	frame.modulate = Color("ffffff")
	control.rect_size = rect_size
	control.rect_position = Vector2.ZERO
	##################
	_control_size(Vector2(rect_size.x, 2))
	_control_position(Vector2(0, rect_size.y/2))
	##################
	_crline_color(Color("ffffff"))
	_frame_color(Color("00ffffff"))
	##################
	yield(get_tree().create_timer(animationSpeed), "timeout")
	_control_size(Vector2(2,2))
	_control_position(rect_size /2)
	##################
	yield(get_tree().create_timer(animationSpeed), "timeout")
	##################
	open = false
	emit_signal("closed")

###########################################################
func _frame_color(target):
	var tween = create_tween()
	tween.tween_property(
		frame,
		"modulate",
		target, 
		animationSpeed)

func _crline_color(target):
	var tween = create_tween()
	tween.tween_property(
		crline,
		"modulate",
		target, 
		animationSpeed)

func _control_size(target):
	var tween = create_tween()
	tween.tween_property(
		control, 
		"rect_size",
		Vector2(target), 
		animationSpeed)

func _control_position(target):
	var tween = create_tween()
	tween.tween_property(
		control, 
		"rect_position", 
		target, 
		animationSpeed)
