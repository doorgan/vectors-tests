tool
extends Node2D

export var radius: float = 50
export var interest_segments: int = 8

func _process(_delta):
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw():
	draw_circle_outline(Vector2.ZERO, radius, Color.black)
	draw_interest_segments()

func draw_interest_segments():
	var target = get_viewport().get_mouse_position() - global_position
	var angle_step = 360.0 / interest_segments
	
	for i in range(interest_segments + 1):
		var angle_point = deg2rad(i * angle_step)
		var angle_vector = Vector2(cos(angle_point), sin(angle_point))
		var segment_start = angle_vector * radius
		var segment_length = max(0, radius/2 * angle_vector.normalized().dot(target.normalized()))
		var segment_end = angle_vector * (radius + segment_length)

		var color = Color.green
		
		draw_line(segment_start, segment_end, color)

func draw_circle_outline(center, rad, color):
	var nb_points = 32
	var points = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(i * 360 / nb_points)
		points.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * rad)

	for index_point in range(nb_points):
		draw_line(points[index_point], points[index_point + 1], color)
