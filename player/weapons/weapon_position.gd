extends Position2D
signal weapon_changed(weapon_name)

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
	world = owner.get_parent()

func _input(event):
	if event.is_action_pressed("hand_gun"):
		anim_player.play("hand_gun")
		current_gun = "hand_gun"
		$CoolDownTimer.wait_time = cool_down_timers[current_gun]
		$CoolDownLoadTimer.wait_time = cool_down_load_timers[current_gun]
	if event.is_action_pressed("machine_gun"):
		anim_player.play("machine_gun")
		current_gun = "machine_gun"
		$CoolDownTimer.wait_time = cool_down_timers[current_gun]
		$CoolDownLoadTimer.wait_time = cool_down_load_timers[current_gun]
	if event.is_action_pressed("hand_gun_silencer"):
		anim_player.play("hand_gun_silencer")
		current_gun = "hand_gun_silencer"
		$CoolDownTimer.wait_time = cool_down_timers[current_gun]
		$CoolDownLoadTimer.wait_time = cool_down_load_timers[current_gun]
	if event.is_action_pressed("no_gun"):
		anim_player.play("no_gun")
		current_gun = "no_gun"
	if event.is_action_pressed("shoot"):
		if current_gun != "no_gun":
			var mouse_pos = owner.get_global_mouse_position()
			var shoot_radius = (mouse_pos - owner.global_position).length()
			if shoot_radius >= owner.shoot_min_radius:
				var shoot_drection = (mouse_pos - global_position).normalized()
				shoot(shoot_drection)
	if event.is_action_pressed("reload"):
		if current_gun != "no_gun":
			reload()


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

func reload():
	$CoolDownLoadTimer.start()
	current_bullets_in_carriage[current_gun] = weapons_carriage[current_gun]
	anim_player.play("load_gun")

func _on_CoolDownLoadTimer_timeout():
	anim_player.play(current_gun)
