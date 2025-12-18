extends Control



func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Levels/level_1.tscn")


func _on_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI_Elements/menu.tscn")
