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

var _separation := Vector2.ZERO
var _avoidance := Vector2.ZERO
var _wall_avoidance := Vector2.ZERO
var _debug_movement := false

var moving = false

func _physics_process(delta):
	if moving:
		if position.distance_to(current_target) > 0:
			move_to(current_target, delta)
		else:
			moving = false
	update()

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		current_target = event.position
		moving = true

func move_to(target: Vector2, delta: float):
	var steering = SB_Arrive.get_steering(self, target, 60)
	var avoidance = SB_AvoidObstacles.get_steering(self)
	var separation = SB_Separation.get_steering(self).acceleration
	var wall_avoidance = SB_AvoidWalls.get_steering(self).acceleration
	_separation = separation * delta
	_avoidance = avoidance * delta
	_wall_avoidance = wall_avoidance * delta

	if steering.acceleration.length() <= 0:
		velocity = velocity.linear_interpolate(Vector2.ZERO, drag)
	else:
		velocity = (velocity + (steering.acceleration + avoidance + separation + wall_avoidance) * delta).clamped(max_speed)

	velocity = move_and_slide(velocity)

func _draw():
	if !_debug_movement:
		return

	draw_line(global_position - position, (global_position - position) + velocity, Color.green)
	draw_line(global_position - position, (global_position - position) + _separation, Color.blue)
	draw_line(global_position - position, (global_position - position) + _avoidance, Color.red)
	draw_line(global_position - position, (global_position - position) + _wall_avoidance, Color.yellow)
