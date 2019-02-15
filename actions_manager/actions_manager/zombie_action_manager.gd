extends "res://actions_manager/action_manager.gd"
var target = null

func _on_Eyes_got_target(_target):
	manage_actions = true
	target = _target


func _on_Eyes_not_got_target(_target):
	manage_actions = false
	target = null
