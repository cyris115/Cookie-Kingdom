extends Control

@onready var quit_confrim: ConfirmationDialog = $CanvasLayer/PanelContainer/VBoxContainer/Quit/QuitConfrim

func _ready() -> void:
	get_tree().paused = false


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/level_select.tscn")


func _on_quit_pressed() -> void:
	quit_confrim.popup_centered()


func _on_quit_confrim_confirmed() -> void:
	get_tree().quit()
