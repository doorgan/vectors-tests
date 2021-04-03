extends SteeringBehavior
class_name SB_Seek

static func get_steering(agent, target: Vector2) -> Vector2:
	var steering = SteeringOutput.new()
	var direction = agent.position.direction_to(target)
	steering.acceleration = (direction * agent.max_accel) - agent.velocity

	return steering
