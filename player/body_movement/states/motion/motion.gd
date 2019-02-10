extends "res://player/body_movement/states/state.gd"


func update_look_direction(new_direction):
	var body_pivot = owner.get_node("BodyPivot")
	body_pivot.look_at(new_direction)
	owner.look_direction = (new_direction - body_pivot.global_position).normalized()

func update_move_direction(new_direction):
	owner.move_direction = new_direction

func get_move_direction():
	var move_direction = Vector2()
	move_direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move_direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return move_direction

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)