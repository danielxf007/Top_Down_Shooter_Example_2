extends KinematicBody2D

var look_direction
var move_direction
var animation = "hand_gun" setget set_animation

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionShape2D.disabled = value
	queue_free()

func set_animation(new_animation):
	animation = new_animation