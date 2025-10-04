extends Control

@onready var label: Label = $ColorRect/Label

func _on_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI_Elements/menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
