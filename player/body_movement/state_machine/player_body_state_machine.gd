extends "res://player/body_movement/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"Idle" : $Idle,
		"Move" : $Move
	}

func _change_state(state_name):
	if not _active:
		return
	._change_state(state_name)