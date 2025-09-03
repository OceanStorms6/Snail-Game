extends CharacterBody2D
class_name Entity

@export var stats:Stats

func _ready() -> void:
	stats.died.connect(OnDeath)
	stats.health = stats.maxHP

func OnDeath() -> void:
	queue_free()
