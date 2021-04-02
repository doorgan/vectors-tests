extends KinematicBody2D

export(int) var max_speed = 400

var velocity: Vector2 = Vector2.ZERO

var current_target: Vector2

func _physics_process(delta):
	if current_target:
		move_to(current_target, delta)

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		current_target = event.position

func move_to(target: Vector2, _delta: float):
	var steering = SB_Arrive.get_steering(self, target, 120)
	var target_velocity = velocity + steering.velocity
	target_velocity = target_velocity.clamped(max_speed)
	if steering.velocity.length() > 0:
		velocity = move_and_slide(target_velocity)
	else:
		velocity = Vector2.ZERO
