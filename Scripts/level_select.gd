extends Control



func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/StoryLevels/level_1.tscn")

func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/StoryLevels/level_2.tscn")


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/StoryLevels/level_3.tscn")


func _on_back_to_main_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/start_menu.tscn")




func _on_demo_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/StoryLevels/test_scene.tscn")
