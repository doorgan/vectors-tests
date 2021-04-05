tool
extends Node2D

export(float) var bounding_radius = 30

func _process(delta: float) -> void:
	if Engine.editor_hint:
		update()

func _draw():
	if Engine.editor_hint:
		DrawUtils.draw_circle_outline(self, global_position - position, bounding_radius, Color.aqua)
