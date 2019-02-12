extends "res://enemies/brain/states/state.gd"

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

func exit():
	body_movement_state = null

func update(state_name):
	emit_signal("finished", state_name)

func move_body(delta):
	return

func handle_animation(ani_name):
	return

func _on_animation_finished(anim_name):
	return
