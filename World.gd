extends Node

var live : int = 3
var score : int = 0

const Ship = preload ("res://Ship.tscn")

onready var lives_label = $lives_label
onready var score_label = $score_label

func _on_Ship_respawn() -> void:
	if live > 0:
		live -= 1
		_change_live_label(live)
	if live >= 1:
		var ship = Ship.instance()
		ship.position = Vector2(48,96)
		get_node("/root").get_child(0).add_child(ship)
	else:
		guardar_record()
		get_tree().change_scene("res://Game_over.tscn")

func _score_up():
	score += 10
	score_label.text = "Score: " + str(score)

func _change_live_label (vidas) -> void:
	lives_label.text = "LIVES: " + str(vidas)

func guardar_record ():
	var save_data = SaveAndLoad.load_data_from_file()
	if score > save_data.highscore:
		save_data.highscore = score
		SaveAndLoad.save_data_to_file(save_data)
