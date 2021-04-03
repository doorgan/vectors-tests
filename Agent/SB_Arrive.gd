extends SteeringBehavior
class_name SB_Arrive

const arrival_tolerance = 10
const time_to_reach = 0.1

static func get_steering(agent, target: Vector2, slow_radius: float) -> Vector2:
	var steering = SteeringOutput.new()
	var direction = agent.position.direction_to(target)
	var distance = agent.position.distance_to(target)

	if distance <= arrival_tolerance:
		steering.acceleration = Vector2.ZERO
		return steering

	var target_speed: float

	if distance <= slow_radius:
		target_speed = agent.max_speed * distance / slow_radius
	else:
		target_speed = agent.max_speed

	var target_velocity = direction * target_speed
	target_velocity = (target_velocity - agent.velocity) / time_to_reach

	steering.acceleration = target_velocity.clamped(agent.max_accel)

	return steering
