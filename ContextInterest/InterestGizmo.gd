extends Node2D

export var radius: float = 50

func _process(_delta):
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw():
	draw_circle_outline(Vector2.ZERO, radius, Color.black)
	draw_interest_segments()

func draw_interest_segments():
	var interest = get_parent().interest
	# var danger = get_parent().danger
	var target = get_viewport().get_mouse_position() - global_position
	var angle_step = 360.0 / interest.size()

	for i in interest.size():
		var angle_point = deg2rad(i * angle_step)
		var angle_vector = Vector2(cos(angle_point), sin(angle_point))
		var segment_start = angle_vector * radius
		# var segment_start_d = angle_vector.rotated(0.03) * radius
		var interest_segment_length = radius/2 * interest[i]
		# var danger_segment_length = radius/2 * max(0, danger[i])
		var interest_segment_end = angle_vector * (radius + interest_segment_length)
		# var danger_segment_end = angle_vector.rotated(0.03) * (radius + danger_segment_length)

		var color = (Color.green if i >= 1 else Color.blue)

		draw_line(segment_start, interest_segment_end, color)
		# draw_line(segment_start_d, danger_segment_end, Color.red)


func draw_circle_outline(center, rad, color):
	var nb_points = 32
	var points = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(i * 360 / nb_points)
		points.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * rad)

	for index_point in range(nb_points):
		draw_line(points[index_point], points[index_point + 1], color)
