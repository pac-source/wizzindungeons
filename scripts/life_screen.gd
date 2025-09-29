extends Control

@onready var label: Label = $ColorRect/Label

func life_indicator():
	label.text = "x" + str(player_variables.player_lives)
