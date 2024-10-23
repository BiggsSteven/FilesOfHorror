extends Node

const PaperDesk = preload("res://scenes/PaperDesk.tscn")

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

func callSnappingEvent(id: int):
	# Called when a snapping happen the id is the sum of the collision mask
	# To translate from list of mask to id is:
	# id = sum(pow(2,mask-1))
	# for example a mask = {1,2,3} has id = 7
	match id:
		2:
			print("Succesfull Snap")
