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
	if player_lives < 0:
		player_lives = 5
		get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")

func player_life():
	player_health -= 1
	if player_health <= 0:
		level_restart()

func level_restart():
	chemical_bottle = 0
	player_lives -= 1
	player_health = 3
	get_tree().reload_current_scene()
