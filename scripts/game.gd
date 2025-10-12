extends Node

class_name game_state

var levels: Array = ["level_1", "level_2", "level_3", "level_4", "level_5", "level_6", "level_7"]
var current_level = ""
var next_level = ""

func _ready() -> void:
	current_level = get_tree().current_scene.name
	next_level = levels.get(levels.find(current_level) + 1)
