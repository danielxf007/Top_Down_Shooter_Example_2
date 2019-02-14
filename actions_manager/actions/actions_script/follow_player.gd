extends "res://actions_manager/actions/action.gd"
var parent
var target
var target_pos
var owner_pos
var body_state_machine
func _ready():
	parent = get_parent()
	body_state_machine = owner.get_node("BodyStateMachine")
	body_state_machine._change_state("Move")
	target = parent.target
	doing_action = true

func can_interrupt():
	return false

func can_do_both(other_action):
	return true

func start_action():
	return

func execute():
	update_target()
	target_pos = target.global_position
	update_look_direction(target_pos)
	owner_pos = owner.global_position
	var look_dir = (target_pos - owner_pos).normalized()
	owner.set_look_direction(look_dir)
	owner.set_move_direction(look_dir)

func is_complete():
	return false

func update_look_direction(target_pos):
	owner.look_at(target_pos)
func _on_ExecutionTimer_timeout():
	return

func update_target():
	target = parent.target