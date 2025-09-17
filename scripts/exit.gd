extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if player_variables.chemical_bottle == 3:
		player_variables.chemical_bottle = 0
		get_tree().change_scene_to_file("res://scenes/game.tscn")
