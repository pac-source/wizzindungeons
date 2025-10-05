extends Node

var player_lives = 5
var player_health = 3

#collectables
var chemical_bottle = 0
var coins_collected = 0
var player_dead = false

func _process(delta) -> void:
	if coins_collected > 99:
		player_lives += 1
		coins_collected = 0
	if player_lives < 0:
		player_lives = 5
		coins_collected = 0
		get_tree().change_scene_to_file("res://scenes/UI_Elements/game_over_screen.tscn")

func player_life():
	player_health -= 1

func level_restart():
	chemical_bottle = 0
	player_lives -= 1
	player_health = 3
	player_dead = false
	get_tree().reload_current_scene()
