extends Resource
class_name Stats

signal died

@export var maxHP:int = 1
var health:int = maxHP:
	set(value):
		if value <= 0:
			died.emit()
			health = 0
		else:
			health = value

@export var speed:int
