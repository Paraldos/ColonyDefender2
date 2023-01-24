extends Button

onready var TR_Left = $HC/TR_Left
onready var TR_Right = $HC/TR_Right
onready var label = $HC/Label
onready var audioClick = $AudioClick
onready var audioAccept = $AudioAccept
onready var audioDenied = $AudioDenied
export var labelText = "???"
export var startFocus = false
var clickSound = false

####################################
func _ready():
	MySignals.connect("grab_focus", self, "_on_grab_focus")
	_frame_visible(false)
	_update()

####################################
func _on_grab_focus():
	if !is_inside_tree(): return
	clickSound = false
	if startFocus: grab_focus()
	clickSound = true
	_update()

####################################
func _update():
	label.text = labelText
	_btn_color()

func _btn_color():
	if disabled:
		modulate = Color("8b8b8b")
	else:
		modulate = Color("ffffff")

####################################
func _frame_visible(x):
	TR_Left.visible = x
	TR_Right.visible = x

####################################
func _on_Button_focus_entered():
	_frame_visible(true)
	if clickSound: audioClick.play()

func _on_Button_focus_exited():
	_frame_visible(false)

####################################
func _on_Button_mouse_entered():
	grab_focus()

####################################
func _denied():
	audioDenied.play()
	modulate = Color("ff0000")
	yield(get_tree().create_timer(0.1), "timeout")
	_update()

####################################
func _disable():
	disabled = true
	_update()

####################################
func _on_Button_gui_input(event):
	if Input.is_action_just_pressed("ui_leftclick") and disabled:
		_denied()
