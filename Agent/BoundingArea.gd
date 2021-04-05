extends Area2D
class_name BoundingArea

export(float) var radius = 50

onready var collider := $CollisionShape2D

func _ready():
	collider.shape.radius = radius

func get_radius():
	return collider.shape.radius
