extends Control
@onready var confirmation_dialog: ConfirmationDialog = $PanelContainer/VBoxContainer/MainMenu/ConfirmationDialog

func _ready():
	hide()

func resume():
	get_tree().paused = false
	hide()
	
func pause():
	get_tree().paused = true
	show()
func testEcs():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()


func _process(_delta):
	testEcs()



func _on_resume_pressed() -> void:
	resume()


func _on_main_menu_pressed() -> void:
	confirmation_dialog.popup_centered()

func _on_confirmation_dialog_confirmed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/start_menu.tscn")
