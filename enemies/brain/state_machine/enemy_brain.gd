extends "res://enemies/brain/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"Patrol" : $Patrol,
		"Attack" : $Attack,
	}

func _change_state(state_name):
	if not _active:
		return
	._change_state(state_name)
