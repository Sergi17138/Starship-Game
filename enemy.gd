extends Area2D

const Tocado = preload ("res://hit.tscn")
const Explosion = preload ("res://Explosion.tscn")
const SPEED = 50

var ARMOR : int = 3

signal score_up

func _ready() -> void:
	var main = get_tree().current_scene
	connect("score_up",main,"_score_up")


func _process(delta: float) -> void:
	position.x -= SPEED * delta

# warning-ignore:unused_argument
func _on_enemy_area_entered(area: Area2D) -> void:
	self.queue_free()

func _on_enemy_body_entered(body: Node) -> void:
	body.queue_free()
	create_new_node(Tocado)
	ARMOR -= 1
	if ARMOR <= 0:
		emit_signal("score_up")
		self.queue_free()
		create_new_node(Explosion)

func create_new_node (Preload_scene):
	var main = get_tree().current_scene
	var preload_scene = Preload_scene.instance()
	preload_scene.global_position = global_position
	main.add_child(preload_scene)
