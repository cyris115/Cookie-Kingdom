class_name Player
extends CharacterBody2D

static var hp: int
static var max_hp = 100

@export var speed = 70.0
@export var run_speed = 110.0
@export var walk_speed = 70.0

var direction := Vector2.RIGHT
static var last_direction := Vector2.RIGHT

var bullet = preload("res://Scenes/Bullet.tscn")
@export var barrel: Node2D
var can_shoot := false

@onready var shoot_timer: Timer = $ShotTimer
@onready var gun: Sprite2D = $GunBarrel/Sprite2D
@onready var body: Sprite2D = $Sprite2D

func _ready() -> void:
	hp = max_hp
	$Label.text = "hp: " + str(hp)



func _physics_process(_delta: float) -> void:
	Shoot()	
	
	direction = Vector2.ZERO
	
	
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
		
	look_at(get_global_mouse_position())


	if Input.is_action_pressed("run"):
		speed = run_speed
	else:
		speed = walk_speed
	
	velocity = direction.normalized() * speed #might need to remove delta idk
		
		
	move_and_slide()



func Shoot():
	if Input.is_action_pressed("shoot") and can_shoot:
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = barrel.global_position
		new_bullet.rotation = (get_global_mouse_position() - global_position).angle()
		get_tree().current_scene.add_child(new_bullet)
		can_shoot = false
		shoot_timer.start()




func _on_shot_timer_timeout() -> void:
	can_shoot = true
