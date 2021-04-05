extends SteeringBehavior
class_name SB_Separation

const threshold = 40
const decay_coeficient = 3.0

static func get_steering(agent):
	var steering = SteeringOutput.new()
	var targets = agent.get_tree().get_nodes_in_group("agent")

	for target in targets:
		if target == agent or target.position.dot(agent.position) < 0.75:
			continue

		var direction = target.position.direction_to(agent.position)
		var distance = agent.position.distance_to(target.position)

		if distance < threshold:
			var strength = min(decay_coeficient * distance * distance, agent.max_accel)

			steering.acceleration = direction * strength

	return steering
