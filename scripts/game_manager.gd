extends Node

class_name game_state

var level: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is Node2D:
			level[child.name] = child
		else:
			print("Level is not of type Node2D")
