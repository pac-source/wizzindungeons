extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_variables.coins_collected += 1
	player_variables.player_score += 100
	animation_player.play("pickup")
	
