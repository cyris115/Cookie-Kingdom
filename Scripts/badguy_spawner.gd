extends Node2D

var badguy = preload("res://Scenes/AssetScenes/Badguy.tscn")
var badguys = []
var wave = 1
@onready var spawn_timer: Timer = $SpawnTimer

signal on_death




func _on_spawn_timer_timeout() -> void:
	var new_badguy = badguy.instantiate()
	new_badguy.on_death.connect(_on_death)
	new_badguy.global_position = global_position
	badguys.append(new_badguy)
	get_tree().current_scene.add_child(new_badguy)

func _on_death() -> void:
	on_death.emit()


func _on_game_manager_wave_increase() -> void:
	for i in badguys:
		if i:
			i.queue_free()
	badguys = []
	wave += 1
	if wave == 2:
		spawn_timer.start(5)
	elif wave == 3:
		spawn_timer.start(3)
