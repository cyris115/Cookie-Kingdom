extends Area2D

@export var radius = 5
@export var damage = 10
@onready var explosion_timer: Timer = $ExplosionTimer

var collision_shape = CollisionShape2D.new()
var circle = CircleShape2D.new()


func _ready():
	circle.radius = radius
	collision_shape.shape = circle
	add_child(collision_shape)
	explosion_timer.start()

func _physics_process(delta: float) -> void:
	var bodies_in_explosion = get_overlapping_bodies()
	for b in bodies_in_explosion:
		if b.is_in_group("badguy"):
			b.take_damage(damage)

func _on_explosion_timer_timeout() -> void:
	queue_free()
