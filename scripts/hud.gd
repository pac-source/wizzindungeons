extends Label

@onready var hud: Label = $"."

func _process(float) -> void:
	hud.text = "Coins: " + str(player_variables.coins_collected)
