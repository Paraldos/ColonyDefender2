extends Node2D

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		if get_tree().get_nodes_in_group("menus").size() <= 0:
			Utils._open_pause()
