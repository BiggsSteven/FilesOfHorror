extends Node

const PaperDesk = preload("res://scenes/PaperDesk.tscn")
signal snappingEvent

func callChangeScene(call: String) -> void:
	match call:
		"Menu":
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
		"Start":
			get_tree().change_scene_to_packed(PaperDesk)
		#"Settings":
		#	get_tree().change_scene_to_file("res://scenes/Settings.tscn")
		"Quit":
			get_tree().quit()

func soundToPlay(name: String) -> void:
	match name:
		"BellRing":
			$BellRing.playSound(2.0)
		"TurnOnLightSigil":
			$TurnOnLightSigil.play()
		"TurnOffLightSigil":
			$TurnOffLightSigil.play()
		"NormalHearthBeat":
			$NormalHearthBeat.play(27.1)
		"SpeedyHearthBeat":
			$SpeedyHearthBeat.play()
		"PageFlip1":
			$PageFlip1.playSound()
		"PageFlip2":
			$PageFlip2.playSound(0.3)
		"PageFlip3":
			$PageFlip3.playSound()
		"PageFlip4":
			$PageFlip4.playSound()
		"PageFlip5":
			$PageFlip5.playSound(.45)
		"Writing":
			$Writing.playSound()
	

func _on_music_the_dark_forest_finished() -> void:
	var previous_volume:float = linear_to_db($"Music-TheDarkForest".volume_db)
	var previous_pitch:float = $"Music-TheDarkForest".pitch_scale
	$"Music-TheDarkForest".pitch_scale = previous_pitch - 0.1
	$"Music-TheDarkForest".volume_db = linear_to_db(previous_volume - 0.1)
	$"Music-TheDarkForest".play()
