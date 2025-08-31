extends Area2D
class_name Grass

const grass_effect:PackedScene = preload("res://world/grass/grass_destroyed.tscn")

func _on_area_entered(area: Area2D) -> void:
	var effect:AnimatedSprite2D = grass_effect.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.global_position = global_position
	queue_free()
