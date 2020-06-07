extends Node

onready var highscore = $highscore_label


func _ready() -> void:
	var save_data = SaveAndLoad.load_data_from_file()
	var record = save_data.highscore
	highscore.text = "HIGHSCORE: " + str (record)
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://start_menu.tscn")
