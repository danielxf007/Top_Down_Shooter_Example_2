extends Node

# Holds the queue of pending actions
var actions_queue = []

# The currently executing actions
var active = []

# The current time, a simple counter in this case
var current_time = 0.0

# Adds an action to the queue
func schedule_action(action):
	actions_queue.push_back(action)
	sort_by_priority(actions_queue)

# Processes the manager
func execute(delta):
	# Update the time
	current_time += delta
	
	# Go through the queue to find interrupters 
	for action in actions_queue:
		# If we drop below active priority, give up
		if action.priority <= active.get_highest_priority():
			break
		# If we have an interrupter, interrupt
		if action.can_interrupt():
			active.clear()
			active = [action]
	
	# Try to add  as many actions to active set as possible
	for action in copy(actions_queue):
		# Check if the action has timed out
		if action.expiry_time <= current_time:
			# Remove it from the action queue
			actions_queue.remove(action)
			# Check if we can combine
			for active_action in active:
				if not action.can_do_both(active_action):
					break
				else:
					actions_queue.remove(action)
					active.append(action)
	sort_by_priority(active)
	# Processes the active set
	for active_action in copy(active):
		# Remove completed actions 
		if active_action.is_complete():
			active.remove(active_action)
		# Execute others
		else:
			active_action.execute()

func copy(object):
	var copy = []
	for element in object:
		copy.push_back(element)
	return copy

func sort_by_priority(actions):
	return