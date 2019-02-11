extends KinematicBody2D

export(float) var speed = 0.0
export(float) var push_force = 0.0 
export(int) var damage = 0
var look_direction = Vector2() setget set_look_direction

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	if is_outside_view_bounds():
		queue_free()
	var velocity = look_direction * speed
	var motion = velocity * delta
	var collision_info = move_and_collide(motion)
	if collision_info:
		queue_free()

func is_outside_view_bounds():
	var out_x_bound = position.x > OS.get_screen_size().x or position.x < 0.0
	var out_y_bound = position.y > OS.get_screen_size().y or position.y < 0.0
	return out_x_bound or out_y_bound

func set_look_direction(new_direction):
	look_direction = new_direction
	look_at(new_direction)