extends Node

func play_sound(stream: AudioStream) -> void:
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	add_child(instance)
	instance.play()
