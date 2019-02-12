extends "res://actions_manager/actions/action.gd"

# Holds the sub-actions 
var actions = []

# Holds the index of the currently executing sub-action
export(int) var active_index = 0

func can_interrupt():
	# We can interrupt if any of ourfirst sub-action can
	return actions[0].can_interrupt()

func can_do_both(other_action):
	# We can do both if all of our sub-actions can
	# If we only test the first one, we'd be in danger
	# of finding ourselves incompatible 
	# mid-sequence
	for action in actions:
		if not action.can_do_both(other_action):
			return false
	return true

func is_complete():
	# We are complete if all of our sub-actions are
	return active_index >= actions.size()

func execute():
	# Execure our current action
	actions[active_index].execute()
	# if our current actions is complete, go to the next
	if actions[active_index].is_complete():
		active_index += 1