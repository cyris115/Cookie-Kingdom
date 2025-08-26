extends Node2D

var kills := 0
var wave := 1
signal wave_increase

func _process(delta: float):
	if wave == 1 and kills >= 10:
		wave += 1
		wave_increase.emit()
		kills = 0
	elif wave == 2 and kills >= 15:
		wave += 1
		wave_increase.emit()
		kills = 0
	elif wave == 3 and kills >= 20:
		get_tree().change_scene_to_file("res://Scenes/StoryLevels/level_2.tscn") 

func _on_badguy_spawner_on_death() -> void:
	kills += 1
