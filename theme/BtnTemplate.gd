extends Button

onready var audioClick = $AudioClick
onready var audioAccept = $AudioAccept
onready var audioDenied = $AudioDenied
export var startFocus = false
var clickSound = false

####################################
func _ready():
	MySignals.connect("grab_focus", self, "_on_grab_focus")

####################################
func _on_grab_focus():
	if !is_inside_tree(): return
	clickSound = false
	if startFocus: grab_focus()
	clickSound = true

####################################
func _on_Button_focus_entered():
	if clickSound: audioClick.play()

####################################
func _on_Button_mouse_entered():
	grab_focus()

####################################
func _accept():
	audioAccept.play()
	modulate = Color("ffee58")
	yield(get_tree().create_timer(0.1), "timeout")
	modulate = Color("ffffff")

func _denied():
	audioDenied.play()
	modulate = Color("ff0000")
	yield(get_tree().create_timer(0.1), "timeout")
	modulate = Color("ffffff")

####################################
func _on_Button_gui_input(event):
	if Input.is_action_just_pressed("ui_leftclick") and disabled:
		_denied()
	if Input.is_action_just_pressed("ui_accept") and disabled:
		_denied()

####################################
func _on_BtnTemplate_pressed():
	if disabled: _denied()
