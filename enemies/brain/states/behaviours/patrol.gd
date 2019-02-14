extends "res://enemies/brain/states/state.gd"

export(bool) var patrol_idle = false
var body_movement
var detect_wall_up
var detect_wall_left
var detect_wall_down
var detect_wall_right
var body_movement_state

func enter():
	set_owner(get_parent().get_parent())
	body_movement = owner.get_node("BodyStateMachine")
	detect_wall_up = owner.get_node("DetectWallUp")
	detect_wall_left = owner.get_node("DetectWallLeft")
	detect_wall_down = owner.get_node("DetectWallDown")
	detect_wall_right = owner.get_node("DetectWallRight")
	var movement
	if patrol_idle:
		movement = "Idle"
	else:
		movement = "Move"
	body_movement._change_state(movement)
	body_movement_state = body_movement.current_state


func exit():
	body_movement_state = null


func update(state_name):
	emit_signal("finished", state_name)

func move_body(delta):
	if not patrol_idle:
		handle_movement_direction()
	body_movement_state.update(delta)

func handle_movement_direction():
	var move_dir
	if detect_wall_right.is_colliding() or detect_wall_up.is_colliding():
		move_dir = owner.get_move_direction() * -1
		owner.set_move_direction(move_dir)
		owner.look_at(owner.global_position + move_dir)
	if detect_wall_left.is_colliding() or detect_wall_down.is_colliding():
		move_dir = owner.get_move_direction() * -1
		owner.set_move_direction(move_dir)
		owner.look_at(owner.global_position + move_dir)
	
func handle_animation(ani_name):
	return

func _on_animation_finished(anim_name):
	return

