tool
extends KinematicBody2D
class_name Agent

export(int) var max_speed = 300
export(int) var max_accel = 4000
export(float) var drag = 0.1
export(float) var bounding_radius = 50
export(bool) var draw_avoid_radius = true

var velocity: Vector2 = Vector2.ZERO
var current_target: Vector2

var moving = false

func _physics_process(delta):
	if moving:
		if position.distance_to(current_target) > 0:
			move_to(current_target, delta)
		else:
			moving = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		current_target = event.position
		moving = true

func move_to(target: Vector2, delta: float):
	var steering = SB_Arrive.get_steering(self, target, 60)
	var avoidance = SB_AvoidObstacles.get_steering(self)
	var separation = SB_Separation.get_steering(self).acceleration

	if steering.acceleration.length() <= 0:
		velocity = velocity.linear_interpolate(Vector2.ZERO, drag)
	else:
		velocity = (velocity + (steering.acceleration + avoidance - separation) * delta).clamped(max_speed)

	velocity = move_and_slide(velocity)
