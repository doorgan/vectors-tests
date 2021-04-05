extends SteeringBehavior
class_name SB_AvoidWalls

const avoid_distance := 100
const lookahead := 60
const whisker_lookahead := 40
const whisker_count = 3
const whisker_angle := deg2rad(45) / whisker_count

static func get_steering(agent):
	var steering = SteeringOutput.new()
	var ray_direction = agent.velocity.normalized()
	var ray_vector = ray_direction * lookahead

	var target: Vector2

	var space_state = agent.get_world_2d().direct_space_state
	var collision = space_state.intersect_ray(agent.global_position, agent.global_position + ray_vector, [agent])
	if collision:
		target = collision.position + collision.normal * avoid_distance
		return SB_Seek.get_steering(agent, target)
	else:
		# left whiskers
		for i in range(whisker_count):
			var whisker_l = ray_direction.rotated(i * whisker_angle) * whisker_lookahead
			var collision_l = space_state.intersect_ray(agent.global_position, agent.global_position + whisker_l, [agent], 32)
			if collision_l:
				target = (ray_direction + Vector2(-ray_direction.y, ray_direction.x)) * avoid_distance
				return SB_Seek.get_steering(agent, target)

		# right whiskers
		for i in range(whisker_count):
			var whisker_r = ray_direction.rotated(i * whisker_angle) * whisker_lookahead
			var collision_r = space_state.intersect_ray(agent.global_position, agent.global_position + whisker_r, [agent], 32)
			if collision_r:
				target = (ray_direction + Vector2(-ray_direction.y, ray_direction.x)) * avoid_distance
				return SB_Seek.get_steering(agent, target)

	return steering
