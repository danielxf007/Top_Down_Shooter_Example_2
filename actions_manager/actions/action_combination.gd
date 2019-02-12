extends "res://actions_manager/actions/action.gd"

#Holds the sub-actions 

var actions = []

func can_interrupt():
	# We can interrupt if any of our sub-actions can
	for action in actions:
		if action.can_interrupt():
			return true
	return false

func can_do_both(other_action):
	# We can do both if all of our sub-actions can
	for action in actions:
		if not action.can_do_both(other_action):
			return false
	return true

func is_complete():
	# We are complete if all of our sub-actions are
	for action in actions:
		if not action.is_complete():
			return false
	return true

func execute():
	# Execure all of our sub-actions
	for action in actions:
		action.execute()