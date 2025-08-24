extends Area2D

@export var speed = 190
var velocity: Vector2
var direction := Vector2.ZERO

func _ready() -> void:
	direction = Vector2.RIGHT.rotated(rotation)
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_area_entered(_area: Area2D) -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		queue_free() #add damage
	if body.is_in_group("badguy"):
		body.queue_free()
