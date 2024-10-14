extends Node

func callChangeScene(call: String):
	match call:
		"Menu":
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
		"Start":
			get_tree().change_scene_to_file("res://scenes/PaperDesk.tscn")
		#"Settings":
		#	get_tree().change_scene_to_file("res://scenes/Settings.tscn")
		"Quit":
			get_tree().quit()
