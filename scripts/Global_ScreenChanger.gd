extends Node

const PaperDesk = preload("res://scenes/PaperDesk.tscn")
signal snappingEvent

func callChangeScene(call: String):
	match call:
		"Menu":
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
		"Start":
			get_tree().change_scene_to_packed(PaperDesk)
		#"Settings":
		#	get_tree().change_scene_to_file("res://scenes/Settings.tscn")
		"Quit":
			get_tree().quit()
