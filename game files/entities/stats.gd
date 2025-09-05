extends Resource
class_name Stats

signal died

@export var maxHP:int
var health:int:
	set(value):
		if value <= 0:
			died.emit()
			health = 0
		else:
			health = value

@export var speed:int
@export var attack:int
