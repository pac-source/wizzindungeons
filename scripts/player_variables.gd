extends Node

var player_lives = 5
var player_health = 3

#collectables
var chemical_bottle = 0
var coins_collected = 0

func _process(_delta) -> void:
	if coins_collected > 99:
		player_lives += 1
		coins_collected = 0

func level_restart():
	chemical_bottle = 0
	player_lives -= 1
	get_tree().reload_current_scene()
