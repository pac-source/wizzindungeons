extends Node

var player_lives = 5
var player_health = 3

#collectables
var chemical_bottle = 0
var coins_collected = 0


func level_restart():
	player_variables.chemical_bottle = 0
	get_tree().reload_current_scene()
