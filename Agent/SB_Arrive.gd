extends SteeringBehavior
class_name SB_Arrive

const arrival_tolerance = 10

static func get_steering(agent, target: Vector2, slow_radius: float) -> Vector2:
	var steering = SteeringOutput.new()
	var distance = agent.position.distance_to(target)
	
	if distance <= arrival_tolerance:
		steering.velocity = Vector2.ZERO
		return steering
	
	var direction = agent.position.direction_to(target)
	var target_speed = agent.max_speed
		
	if distance <= slow_radius:
		target_speed *= distance / slow_radius
	
	var target_velocity = direction * target_speed
	target_velocity = target_velocity - agent.velocity
	
	steering.velocity = target_velocity.clamped(agent.max_speed)
	
	return steering
