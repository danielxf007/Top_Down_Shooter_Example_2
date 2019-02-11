extends "res://player/body_movement/states/state.gd"


func update_look_direction(new_direction):
	var body_pivot = owner.get_node("BodyPivot")
	var player_collision_shape = owner.get_node("CollisionShape2D")
	var scope = owner.get_node("WeaponScope")
	scope.global_position = new_direction
	player_collision_shape.look_at(new_direction)
	body_pivot.look_at(new_direction)
	owner.look_direction = (new_direction - body_pivot.global_position).normalized()

func update_move_direction(new_direction):
	owner.move_direction = new_direction

func get_look_position():
	return owner.get_global_mouse_position()

func get_move_direction():
	var move_direction = Vector2()
	move_direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move_direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return move_direction

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)