extends Control

@onready var label: Label = $ColorRect/VBoxContainer/Label

func _ready() -> void:
	label.text = "Congratulations!\nYou've completed the game\nYour total score is: " + str(player_variables.player_score)

func _on_to_menu_pressed() -> void:
	player_variables.player_score = 0
	get_tree().change_scene_to_file("res://scenes/UI_Elements/menu.tscn")

func _on_exit_pressed() -> void:
	player_variables.player_score = 0
	get_tree().quit()
