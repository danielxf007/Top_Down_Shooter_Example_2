extends Node

export(int) var priority
export(bool) var include_action = true
var doing_action = false

func can_interrupt():
	return

func can_do_both(other_action):
	return

func start_action():
	return

func execute():
	return

func is_complete():
	return

func _on_ExecutionTimer_timeout():
	return
