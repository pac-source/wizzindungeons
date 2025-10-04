extends game_state

func _on_area_2d_body_entered(body: Node2D) -> void:
	if player_variables.chemical_bottle == 3:
		player_variables.chemical_bottle = 0
		if next_level != null:
			get_tree().change_scene_to_file("res://scenes/Levels/" + str(next_level) + ".tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/UI_Elements/life_screen.tscn")
