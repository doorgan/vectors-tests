extends Node2D

var max_dist = 200.0

var interest = []
var danger = []
var directions = []

func _ready():
	interest.resize(12)
	danger.resize(12)
	directions.resize(12)
	for i in range(12):
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
			var dir = position - interest.position
			var dot = direction.normalized().dot(dir.normalized())
			interest_values.append(dot)
		var sum = 0
		for value in interest_values:
			sum += value
		
		interest[i] = sum
	return interest
