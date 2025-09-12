extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_area_entered(area: Area2D) -> void:
	player_variables.chemical_bottle += 1
	animation_player.play("pickup")
	
