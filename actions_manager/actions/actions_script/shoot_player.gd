extends "res://actions_manager/actions/action.gd"

var weapon
var weapon_pos
var parent
var can_shoot = true
var target
var target_pos

func _ready():
	weapon = owner.get_node("WeaponPos")
	parent = get_parent()
	target = parent.target
	doing_action = true

func can_interrupt():
	return false

func can_do_both(other_action):
	return true

func start_action():
	return

func execute():
	if target == null:
		update_target()
	if can_shoot:
		target_pos = target.global_position
		update_look_direction(target_pos)
		weapon_pos = weapon.global_position
		var shoot_direction = (target_pos - weapon_pos).normalized()
		weapon.shoot(shoot_direction)
	else:
		weapon.reload()

func is_complete():
	return false

func _on_ExecutionTimer_timeout():
	return

func _on_WeaponPos_ran_out_of_bullets():
	can_shoot = false


func _on_WeaponPos_weapon_loaded():
	can_shoot = true

func update_target():
	target = parent.target

func update_look_direction(target_pos):
	owner.look_at(target_pos)