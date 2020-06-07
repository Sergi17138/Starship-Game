extends Area2D

const Bullet = preload ("res://bullet.tscn")
const Explosion = preload ("res://Explosion.tscn")

const SPEED = 100

onready var motor = $Motor

signal respawn

func _ready() -> void:
	var main = get_tree().current_scene
# warning-ignore:return_value_discarded
	connect ("respawn", main, "_on_Ship_respawn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		fire_bullet()
	if Input.is_action_pressed("ui_down") and position.y < 170:
		position.y += SPEED * delta
		motor.process_material.set("direction", Vector3(1,1,0))
	if Input.is_action_just_released("ui_down"):
		motor.process_material.set("direction", Vector3(1,0,0))
	if Input.is_action_pressed("ui_up") and position.y > 19:
		position.y -= SPEED * delta
		motor.process_material.set("direction", Vector3(1,-1,0))
	if Input.is_action_just_released("ui_up"):
		motor.process_material.set("direction", Vector3(1,0,0))
	if Input.is_action_pressed("ui_right") and position.x < 310:
		position.x += SPEED * delta
		motor.process_material.set("emission_sphere_radius", 2)
		motor.lifetime = 0.5
		motor.speed_scale = 2.0
	if Input.is_action_just_released("ui_right"):
		motor.process_material.set("emission_sphere_radius", 5)
		motor.lifetime = 0.25
		motor.speed_scale = 1
	if Input.is_action_pressed("ui_left") and position.x > 8:
		position.x -= SPEED * delta
		motor.emitting = false
	if Input.is_action_just_released("ui_left"):
		motor.emitting = true

func fire_bullet():
	create_new_node(Bullet)

func respawn_player() -> void:
	emit_signal("respawn")

func _on_Ship_area_entered(area: Area2D) -> void:
	area.queue_free()
	queue_free()
	respawn_player()
 
func _exit_tree() -> void:
	create_new_node(Explosion)

func create_new_node (Preload_scene):
	var preload_scene = Preload_scene.instance()
	preload_scene.global_position = self.global_position
	get_node("/root").get_child(0).add_child(preload_scene)
	

