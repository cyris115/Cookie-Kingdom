extends Area2D

@export var speed = 190
@export var damage = 25
var velocity: Vector2
var direction := Vector2.ZERO
var explosion = preload("res://Scenes/AssetScenes/magic_explosion.tscn")

func _ready() -> void:
	direction = Vector2.RIGHT.rotated(rotation)
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_area_entered(_area: Area2D) -> void:
	new_explosion()

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		new_explosion()

func new_explosion():
	var new_explosion = explosion.instantiate()
	new_explosion.global_position = global_position
	get_tree().current_scene.add_child(new_explosion)
	queue_free()
