extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_area_entered(area: Area2D) -> void:
	player_variables.player_score += 500
	player_variables.chemical_bottle += 1
	player_variables.player_health = 3
	animation_player.play("pickup")
	
