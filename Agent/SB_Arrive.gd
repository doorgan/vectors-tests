extends SteeringBehavior
class_name SB_Arrive

const arrival_tolerance = 10

static func get_steering(agent, target: Vector2, slow_radius: float) -> Vector2:
	var steering = SteeringOutput.new()
	var direction = agent.position.direction_to(target)
	var distance = agent.position.distance_to(target)
	
	if distance <= arrival_tolerance:
		return steering

	var target_speed: float

	if distance <= slow_radius:
		target_speed = agent.max_speed * distance / slow_radius
	else:
		target_speed = agent.max_speed

	var target_velocity = direction * target_speed
	target_velocity = (target_velocity - agent.velocity) / 0.1
	
	print("++++")
	print(target_velocity)
	print(agent.velocity)
	print(target_velocity.clamped(agent.max_speed))
	print("----")

	steering.velocity = target_velocity.clamped(agent.max_speed)

	return steering
