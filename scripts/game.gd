extends Node2D


func _on_death_zone_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
