extends Button

onready var TR_Left = $HC/TR_Left
onready var TR_Right = $HC/TR_Right
onready var label = $HC/Label
onready var audioClick = $AudioClick
export var labelText = "???"
export var startFocus = false
var start = true

####################################
func _ready():
	# warning-ignore:return_value_discarded
	MySignals.connect("grab_focus", self, "_on_grab_focus")
	_frame_visible(false)
	label.text = labelText
	_focus()
	if disabled: modulate = Color("505050")

func _on_grab_focus():
	start = true
	if startFocus: grab_focus()
	start = false

func _focus():
	if startFocus: grab_focus()
	start = false

####################################
func _frame_visible(x):
	TR_Left.visible = x
	TR_Right.visible = x

####################################
func _on_Button_focus_entered():
	_frame_visible(true)
	if !start:
		audioClick.play()

func _on_Button_focus_exited():
	_frame_visible(false)

####################################
func _on_Button_mouse_entered():
	grab_focus()

####################################
func _disable():
	disabled = true
	modulate = Color("505050")
