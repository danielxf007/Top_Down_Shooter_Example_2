extends Node2D

signal player_entered(player)
signal player_exited(player)
export (int) var detect_radius = 100
var vis_color = Color(.867, .91, .247, 0.1)
var laser_color = Color(1.0, .329, .298)
var target = null
var hit_pos

func _ready():
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	var visibility = owner.get_node("Visibility")
	visibility.get_node("CollisionShape2D").shape = shape


func _on_Visibility_body_entered(body):
	if target != null or body.name != "Player":
		return
	target = body
	var brain = owner.get_node("Brain")
	brain._change_state("Attack")
	emit_signal("player_entered", body)

func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)

func _on_Visibility_body_exited(body):
	if body == target:
		target = null
		var brain = owner.get_node("Brain")
		brain._change_state("Patrol")
		emit_signal("player_exited", body)