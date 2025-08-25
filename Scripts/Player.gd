class_name Player
extends CharacterBody2D

static var max_hp = 100
static var max_stam = 100
static var hp = 100:
	set(value):
		hp = clamp(value, 0, max_hp)
static var stam = 100:
	set(value):
		stam = clamp(value, 0, max_stam)


@export var speed = 70.0
@export var run_speed = 110.0
@export var walk_speed = 70.0
@export var stam_drain_rate = 33.333 #Stamina drain in stam/second
@export var stam_regen_rate = 20 #Stamina gain in stam/second

var direction := Vector2.RIGHT
static var last_direction := Vector2.RIGHT

var bullet = preload("res://Scenes/Bullet.tscn")
@export var barrel: Node2D
var can_shoot := false
var can_damage := true
var can_sprint := true
var is_sprinting := false

@onready var invincibility_timer: Timer = $InvincibilityTimer
@onready var shoot_timer: Timer = $ShotTimer
@onready var stam_timer: Timer = $StamTimer
@onready var gun: Sprite2D = $GunBarrel/Sprite2D
@onready var body: Sprite2D = $Sprite2D
@onready var hp_label: Label = $HPLabel
@onready var stam_label: Label = $StamLabel

func _ready() -> void:
	hp = max_hp
	hp_label.text = "hp: " + str(hp)
	stam = max_stam
	stam_label.text = "stamina: " + str(stam)



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


	if Input.is_action_pressed("run") and can_sprint:
		speed = run_speed
		is_sprinting = true
	else:
		speed = walk_speed
		is_sprinting = false
		
	if is_sprinting:
		stam -= stam_drain_rate * _delta
		if stam <= 0:
			can_sprint = false
			stam_timer.start()
	else:
		stam += stam_regen_rate * _delta
	stam_label.text = "stamina: " + str(roundi(stam))
	
	velocity = direction.normalized() * speed #might need to remove delta idk
		
		
	move_and_slide()
	
	#Collision code
	if can_damage:
		for i in get_slide_collision_count():
			var body = get_slide_collision(i).get_collider()
			if body.is_in_group("badguy"):
				take_damage(5)
				can_damage = false
				invincibility_timer.start()
				break


func Shoot():
	if Input.is_action_pressed("shoot") and can_shoot:
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = barrel.global_position
		new_bullet.rotation = (get_global_mouse_position() - global_position).angle()
		get_tree().current_scene.add_child(new_bullet)
		can_shoot = false
		shoot_timer.start()

func take_damage(dmg: int):
	hp -= dmg
	if hp < 0:
		#Likely need to add other code here
		hp = 0
	hp_label.text = "hp: " + str(hp)


func _on_shot_timer_timeout() -> void:
	can_shoot = true

func _on_invincibility_timer_timeout() -> void:
	can_damage = true

func _on_stam_timer_timeout() -> void:
	can_sprint = true
