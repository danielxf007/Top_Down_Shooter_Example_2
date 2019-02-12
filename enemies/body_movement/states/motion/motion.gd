extends "res://enemies/body_movement/states/state.gd"

func update_look_direction(new_direction):
	return


func update_move_direction(new_direction):
	return

func get_look_direction():
	return 

func get_move_direction():
	return

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)
