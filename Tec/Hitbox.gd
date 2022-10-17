extends Area2D

export var dmg = 1

func _on_Hitbox_area_entered(area):
	area.emit_signal("hit", dmg)
