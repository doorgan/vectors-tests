extends Node2D

var max_dist = 200.0

var interest = []
var danger = []
var directions = []

func _init():
	directions.resize(12)
	for i in range(12):
		interest.append(0)
		danger.append(0)
		var angle = (i * 2 * PI) / 12
		directions[i] = Vector2.RIGHT.rotated(angle)
		
func update_interests():
	var interests = bh_chase()
	var dangers = bh_avoid()
	interest = interests
	danger = dangers
	print(dangers)

func bh_avoid():
	var danger_arr = []
	danger_arr.resize(directions.size())
	
	var dangers = get_tree().get_nodes_in_group("Danger")
	
	for i in directions.size():
		var direction = directions[i]

		var danger_values = []

		for danger in dangers:
			var distance = position.distance_to(danger.position)
			var dir = danger.position - position
			var dot = direction.normalized().dot(dir.normalized())
			if distance < 200 and dot > 0.65:
				var distance_ratio = distance/200
				var final_value = dot / distance_ratio
				prints("dot: %s, dist: %s, value: %s" % [dot, distance_ratio, final_value])
				danger_values.append(final_value)

		var sum = 0
		for value in danger_values:
			sum += value

		if danger_values.size() > 0:
			danger_arr[i] = sum/danger_values.size()
		else:
			danger_arr[i] = 0

	return normalize(danger_arr)
	
func bh_chase():
	var interest_arr = []
	interest_arr.resize(directions.size())
	var interests = get_tree().get_nodes_in_group("Interest")
	for i in directions.size():
		var direction = directions[i]

		var interest_values = []

		for interest in interests:
			var distance = position.distance_to(interest.position)
			var dir = interest.position - position
			var dot = direction.normalized().dot(dir.normalized())
			if distance < 500 and dot > 0:
				interest_values.append(dot / (distance / 500))

		var sum = 0

		for value in interest_values:
			sum += value
		if interest_values.size() > 0:
			interest_arr[i] = sum/interest_values.size()
		else:
			interest_arr[i] = 0

	return normalize(interest_arr)

func _max(list):
	var ret
	for val in list:
		if not ret:
			ret = val
		else:
			if val > ret:
				ret = val
	return ret

func _min(list):
	var ret
	for val in list:
		if not ret:
			ret = val
		else:
			if val < ret:
				ret = val
	return ret
	
func normalize(list: Array):	
	var maxim = _max(list)
	maxim = (1 if not maxim else maxim)
	
	var ret = []
	
	for x in list:
		var val = max(0, x) / (maxim / 0.8)
		ret.append(val)

	return ret

func maprange(a1, a2, b1, b2, s):
	return b1 + (s-a1)*(b2-b1)/(a2-a1)
