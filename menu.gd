extends Node2D


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://slime.tscn")