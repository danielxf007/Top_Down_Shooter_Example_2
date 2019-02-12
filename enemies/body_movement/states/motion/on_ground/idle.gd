extends "res://enemies/body_movement/states/motion/on_ground/on_ground.gd"

func enter():
	handle_animation(owner.animation)

func update(delta):
	var look_direction = get_look_position()
	update_look_direction(look_direction)
	var move_direction = get_move_direction()
	if is_moving(move_direction):
		emit_signal("finished", "Move")

func is_moving(move_direction):
	if move_direction == Vector2():
		return false
	else:
		return true