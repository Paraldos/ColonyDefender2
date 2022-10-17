extends Area2D

export var label = true

# warning-ignore:unused_signal
signal hit(dmg)

func _on_Hurtbox_hit(dmg):
	if label:
		Utils._dmg_label(dmg, global_position)
