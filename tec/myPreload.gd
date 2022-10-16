extends Node

var GAMEOVERMENU = preload("res://menu/GameOverMenu.tscn")
var PAUSEMENU = preload("res://menu/PauseMenu.tscn")
var DMGLABEL = preload("res://tec/DmgLabel.tscn")
var MEGABOMB = preload("res://player/Megabomb.tscn")
var MEGALSER = preload("res://player/Megalaser.tscn")
var MEGASHIELD = preload("res://player/MegaShield.tscn")
var FIGHTER01 = preload("res://enemies/Fighter01.tscn")
var FIGHTER02 = preload("res://enemies/Fighter02.tscn")
var GUNSHIP = preload("res://enemies/Gunship.tscn")
var MISSILE = preload("res://enemies/Missile.tscn")
var powerup_hp = preload("res://Powerup/HP.tscn")
var powerup_energy = preload("res://Powerup/Energy.tscn")
var CREDITS = preload("res://Powerup/Credits.tscn")

var BACKGROUND_TEXTURES = [
	preload("res://img/Space_01-Sheet.png"),
	preload("res://img/Space_02-Sheet.png"),
	preload("res://img/Space_03-Sheet.png"),
	preload("res://img/Space_04-Sheet.png")
]
var PROJECTILE = [
	null,
	preload("res://projectile/Projectile01.tscn"),
	preload("res://projectile/Projectile02.tscn"),
	preload("res://projectile/Projectile03.tscn"),
]
var EXPLOSIONS = [
	null,
	preload("res://explosions/Explosion01.tscn"),
	preload("res://explosions/Explosion02.tscn"),
	preload("res://explosions/Explosion03.tscn"),
	preload("res://explosions/Explosion04.tscn")
]
var ASTEROIDS = [
	preload("res://enemies/Asteroid01.tscn"),
	preload("res://enemies/Asteroid02.tscn"),
	preload("res://enemies/Asteroid03.tscn"),
	preload("res://enemies/Asteroid04.tscn"),
	preload("res://enemies/Asteroid05.tscn"),
	preload("res://enemies/Asteroid06.tscn"),
]
var SONGS = [
	preload("res://music/laserattack.wav"),
	preload("res://music/Laser Quest Loop.wav"),
	preload("res://music/The Synths Loop.wav"),
]


