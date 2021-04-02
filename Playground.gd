extends Node2D

onready var INTEREST = preload("res://ContextInterest/Interest.tscn")
onready var DANGER = preload("res://ContextInterest/Danger.tscn")

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				var interest = INTEREST.instance()
				add_child(interest)
				interest.global_position = event.position
			BUTTON_RIGHT:
				var danger = DANGER.instance()
				add_child(danger)
				danger.global_position = event.position

	if event.is_action_released("interests_clear"):
		for n in get_tree().get_nodes_in_group("Interest"):
			n.queue_free()
		for n in get_tree().get_nodes_in_group("Danger"):
			n.queue_free()
