extends Area2D


func _on_area_entered(area: Area2D) -> void:
	player_variables.coins_collected = 0
	get_tree().reload_current_scene()
