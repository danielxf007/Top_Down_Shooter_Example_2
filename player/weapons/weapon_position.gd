extends Position2D
signal weapon_changed(weapon_name)

var type_of_bullets = {"hand_gun": preload("res://bullets/HandGunBullet.tscn"),
"machine_gun" : preload("res://bullets/MachineGunBullet.tscn"), 
"hand_gun_silencer" : preload("res://bullets/HandGunSilencerBullet.tscn")}
var weapons_carriage = {"hand_gun" : 10, "machine_gun" : 25,
"hand_gun_silencer" : 8}
var current_bullets_in_carriage = {"hand_gun" : 10, "machine_gun" : 25,
"hand_gun_silencer" : 8}
var cool_down_timers = {"hand_gun" : 1, "machine_gun" : 0.5,
"hand_gun_silencer" : 2}
var cool_down_load_timers = {"hand_gun" : 2, "machine_gun" : 1.5,
"hand_gun_silencer" : 2.5}