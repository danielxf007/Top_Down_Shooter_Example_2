extends "res://actions_manager/action_manager.gd"
var target = null

func _on_Eyes_player_entered(player):
	manage_actions = true
	target = player


func _on_Eyes_player_exited(player):
	manage_actions = false
	target = null
