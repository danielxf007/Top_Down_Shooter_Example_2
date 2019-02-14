extends KinematicBody2D

var look_direction = Vector2() setget set_look_direction, get_look_direction
export(Vector2) var move_direction = Vector2() setget set_move_direction, get_look_direction
export(String) var animation = "hand_gun" setget set_animation

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionShape2D.disabled = value
	queue_free()

func set_animation(new_animation):
	animation = new_animation

func set_look_direction(direction):
	look_direction = direction

func get_look_direction():
	return look_direction

func set_move_direction(direction):
	move_direction = direction

func get_move_direction():
	return move_direction

func _on_DamageZone_body_entered(body):
	pass # replace with function body
