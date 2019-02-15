extends Node

# Holds the queue of pending actions
var actions_queue = []

# The currently executing actions
var active = []

var manage_actions = false

func _ready():
	for child in get_children():
		if child.include_action:
			schedule_action(child)
			schedule_move_active_actions(child)
# Adds an action to the queue
func schedule_action(action):
	actions_queue.push_back(action)

func schedule_move_active_actions(action):
	active.push_back(action)

func _physics_process(delta):
	if manage_actions:
		execute()

# Processes the manager
func execute():
	# Processes the active set
	for active_action in copy(active):
		# Remove completed actions 
		if active_action.is_complete():
			active.remove(active_action)
			actions_queue.push_back(active_action)
		# Execute others
		else:
			active_action.execute()
"""Go through the queue to find interrupters 
	for action in actions_queue:
		# If we drop below active priority, give up
		if action.priority <= active.get_highest_priority():
			break
		# If we have an interrupter, interrupt
		if action.can_interrupt():
			active.clear()
			active = [action]"""

func copy(object):
	var copy = []
	for element in object:
		copy.push_back(element)
	return copy

func add_actions_to_active():
	# Try to add  as many actions to active set as possible
	for action in copy(actions_queue):
		# Check if the action has timed out
		if not action.doing_action:
			# Remove it from the action queue
			actions_queue.remove(action)
			# Check if we can combine
			for active_action in copy(active):
				if not action.can_do_both(active_action):
					break
				else:
					actions_queue.remove(action)
					active.append(action)

func sort_by_priority(actions):
	return