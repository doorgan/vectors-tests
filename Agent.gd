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
	bh_chase()
	print(interest)

func bh_avoid():
	pass
	
func bh_chase():
	var interests = get_tree().get_nodes_in_group("Interest")
	for i in directions.size():
		var direction = directions[i]
		var interest_values = []
		for interest in interests:
			var distance = position.distance_to(interest.position)
			var dir = interest.position - position
			var dot = direction.normalized().dot(dir.normalized())
			interest_values.append(distance * dot)
		var sum = 0
		
		var values = _normalize(interest_values)
		
		for value in values:
			sum += value
		
		interest[i] = sum/values.size()
	return interest


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
	
func _normalize(list):
	print("=normalize=")
	print(list)
	var maxim = _max(list)
	var minim = _min(list)
	
	var average = (minim + maxim) / 2
	var rang = (maxim - minim) / 2
	
	var ret = []
	
	for x in list:
		var val = (x - average) / rang
		ret.append(val)
	print(ret)
	print("=end normalize=")
	return ret
