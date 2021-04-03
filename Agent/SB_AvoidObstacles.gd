extends SteeringBehavior
class_name SB_AvoidObstacles

const max_seek_ahead = 50
const max_avoid_accel = 2000

static func get_steering(agent):
	var ahead = agent.position + agent.velocity.normalized() * max_seek_ahead
	var ahead2 = agent.position + agent.velocity.normalized() * max_seek_ahead * 0.5

	var most_threatening: Vector2
	var avoidance := Vector2.ZERO

	var obstacles = agent.get_tree().get_nodes_in_group("obstacle")
	for obstacle in obstacles:
		var collision = line_intersects_circle(ahead, ahead2, obstacle.position, 50)

		if collision and (most_threatening == null or agent.position.distance_to(obstacle.position) < agent.position.distance_to(most_threatening)):
			most_threatening = obstacle.position

	if most_threatening:
		avoidance.x = ahead.x - most_threatening.x
		avoidance.y = ahead.y - most_threatening.y
		avoidance = avoidance.normalized() * max_avoid_accel

	return avoidance

static func line_intersects_circle(ahead: Vector2, ahead2: Vector2, obstacle: Vector2, radius: float) -> bool:
	return obstacle.distance_to(ahead) <= radius or obstacle.distance_to(ahead2) <= radius
