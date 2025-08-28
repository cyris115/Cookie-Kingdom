extends CharacterBody2D

var hp = 100
static var max_hp = 100

var speed:= 30
@export var detect_radius: float = 160.0

var player: Node2D
var can_damage := true
@onready var inv_timer: Timer = $InvTimer

signal on_death()

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(_delta: float) -> void:
	if not player:
		return
		
	var distance = global_position.distance_to(player.global_position)
	if distance <= detect_radius:
		var direction = (player.global_position - global_position).normalized()
		
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func take_damage(dmg: int):
	if can_damage:
		hp -= dmg
		if hp <= 0:
			on_death.emit()
			queue_free()
		else:
			$Label.text = "hp: " + str(hp)
			can_damage = false
			inv_timer.start()

func _on_inv_timer_timeout() -> void:
	can_damage = true
