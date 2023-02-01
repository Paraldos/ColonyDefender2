extends Node

signal start_background(x, y)
signal stop_background()

signal asteroids_start()
signal debris_start()
signal asteroids_stop()
signal debris_stop()

signal hp_update()
signal energy_update()
signal credits_update()

signal grab_focus()

signal megalaser_off()
signal megashield_on()
signal megashield_off()

signal end_stage(wait_time)
signal stop_ui()
signal shop_info(id)

signal mission_info()
