extends Node2D

const Enemy = preload ("res://enemy.tscn")

onready var positions = $Span_positions

func get_random_position ():
	var puntos_spawn = positions.get_children()
	puntos_spawn.shuffle()
	return puntos_spawn[0].global_position


func _on_Timer_timeout() -> void:
	var main = get_tree().current_scene
	var enemy = Enemy.instance()
	var posicion = get_random_position()
	enemy.position = posicion
	main.add_child(enemy)
	
