extends Button

onready var TR_Left = $HC/TR_Left
onready var TR_Right = $HC/TR_Right
onready var label = $HC/Label
onready var audio = $Audio

export var labelText = "???"
export var startFocus = false
var start = true

####################################
func _ready():
# warning-ignore:return_value_discarded
	MySignals.connect("grab_focus", self, "_on_grab_focus")
	TR_Left.visible = false
	TR_Right.visible = false
	label.text = labelText
	_focus()

func _on_grab_focus():
	start = true
	if startFocus: grab_focus()
	start = false

func _focus():
	if startFocus: grab_focus()
	start = false

####################################
func _on_Button_focus_entered():
	TR_Left.visible = true
	TR_Right.visible = true
	if !start:
		audio.play()

func _on_Button_focus_exited():
	TR_Left.visible = false
	TR_Right.visible = false

####################################
func _on_Button_mouse_entered():
	grab_focus()
