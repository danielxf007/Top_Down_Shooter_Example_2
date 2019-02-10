extends "res://player/body_movement/states/motion/on_ground/on_ground.gd"

var speed 

func enter():
	speed = 0.0
	handle_animation("walk")

func update(delta):
	var mouse_position = get_look_position()
	update_look_direction(mouse_position)
	var move_direction = get_move_direction()
	update_move_direction(move_direction)
	if is_moving(move_direction):
		move(move_direction, delta)
	else:
		emit_signal("finished", "Idle")

func is_moving(move_direction):
	if move_direction == Vector2():
		return false
	else:
		return true

func calculate_speed(acceleration, delta):
	speed += acceleration * delta
	var speed_sign = sign(speed)
	if abs(speed) > MAX_SPEED:
		speed = MAX_SPEED * speed_sign
	if abs(speed) < MIN_SPEED:
		speed = MIN_SPEED * speed_sign

func move(direction, delta):
	calculate_speed(move_force, delta)
	var velocity = direction * speed
	owner.move_and_slide(velocity)