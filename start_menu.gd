extends Node

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://World.tscn")

func _on_Button2_pressed() -> void:
	get_tree().quit()
