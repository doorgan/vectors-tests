tool
extends Node2D

export var radius: float = 500
export var interest_segments: int = 8

func _process(_delta):
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw():
	draw_circle_outline(global_position, radius, Color.black)
	draw_interest_segments()

func draw_interest_segments():
	var interest = get_viewport().get_mouse_position()
	var angle_step = 360.0 / interest_segments
	for i in range(interest_segments + 1):
		var angle_point = deg2rad(i * angle_step)
		var pos = Vector2(cos(angle_point), sin(angle_point)) * radius
		var segment = pos - global_position
		draw_line(global_position, segment * segment.normalized().dot(interest.normalized()), Color.black)

func draw_circle_outline(center, rad, color):
	var nb_points = 32
	var points = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(i * 360 / nb_points)
		points.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * rad)

	for index_point in range(nb_points):
		draw_line(points[index_point], points[index_point + 1], color)
