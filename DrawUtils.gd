class_name DrawUtils

static func draw_circle_outline(context: Node2D, center: Vector2, rad: float, color: Color):
	var nb_points = 32
	var points = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(i * 360 / nb_points)
		points.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * rad)

	for index_point in range(nb_points):
		context.draw_line(points[index_point], points[index_point + 1], color)
