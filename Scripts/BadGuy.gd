extends CharacterBody2D

static var hp = 100
static var max_hp = 100

var speed:= 30
@export var detect_radius: float = 160.0

var player: Node2D

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
