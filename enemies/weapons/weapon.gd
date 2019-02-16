extends Position2D

signal weapon_changed(weapon_name)
signal ran_out_of_bullets()
signal weapon_loaded()

var type_of_bullets = {"hand_gun": preload("res://bullets/HandGunBullet.tscn"),
"machine_gun" : preload("res://bullets/MachineGunBullet.tscn"), 
"hand_gun_silencer" : preload("res://bullets/HandGunSilencerBullet.tscn")}
var weapons_carriage = {"hand_gun" : 10, "machine_gun" : 25,
"hand_gun_silencer" : 8}
var current_bullets_in_carriage = {"hand_gun" : 10, "machine_gun" : 25,
"hand_gun_silencer" : 8}
var cool_down_timers = {"hand_gun" : 0.5, "machine_gun" : 0.15,
"hand_gun_silencer" : 0.75}
var cool_down_load_timers = {"hand_gun" : 1, "machine_gun" : 1,
"hand_gun_silencer" : 1.25}
var rounds_at_once = {"hand_gun" : 1, "machine_gun" : 3,
"hand_gun_silencer" : 1}
var anim_player
export(String) var current_gun
var world

func _ready():
	anim_player = owner.get_node("AnimationPlayer")
	for w in get_tree().get_nodes_in_group("world"):
		world = w
	$CoolDownTimer.wait_time = cool_down_timers[current_gun]
	$CoolDownLoadTimer.wait_time = cool_down_load_timers[current_gun]

func shoot(direction):
	if current_bullets_in_carriage[current_gun] <= 0:
		return
	if not $CoolDownLoadTimer.is_stopped():
		return
	if not $CoolDownTimer.is_stopped():
		return
	$CoolDownTimer.start()
	current_bullets_in_carriage[current_gun] -= 1
	var new_bullet = type_of_bullets[current_gun].instance()
	new_bullet.global_position = global_position
	new_bullet.set_look_direction(direction)
	new_bullet.add_collision_exception_with(owner)
	world.add_child(new_bullet)
	if current_bullets_in_carriage[current_gun] <= 0:
		reload()
		emit_signal("ran_out_of_bullets")

func reload():
	$CoolDownLoadTimer.start()
	current_bullets_in_carriage[current_gun] = weapons_carriage[current_gun]
	anim_player.play("load_gun")

func _on_CoolDownLoadTimer_timeout():
	anim_player.play(current_gun)
	emit_signal("weapon_loaded")