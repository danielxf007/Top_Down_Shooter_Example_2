extends KinematicBody2D

var look_direction
var move_direction

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionShape2D.disabled = value
	queue_free()
