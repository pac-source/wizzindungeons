extends Node2D


func _on_death_zone_area_entered(area: Area2D) -> void:
	#get_tree().change_scene_to_file("res://scenes/game.tscn")
	player_variables.coins_collected = 0
