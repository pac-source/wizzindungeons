extends Label

@onready var lives: Label = $"."

func _process(float) -> void:
	lives.text = "Lives: " + str(player_variables.player_lives)
