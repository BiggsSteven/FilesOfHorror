extends AudioStreamPlayer

@export var pitch_min:float = 1.0
@export var pitch_max:float = 1.0
@export var retrigger_time:float = 0.032

var last_play_time:float

func get_pitch()->float:
	return randf_range(pitch_min,pitch_max)

func playSound(from_position:float = 0.0)->void:
	var time = Time.get_ticks_msec() * 0.001
	if time < last_play_time + retrigger_time:
		return
	last_play_time = time
	pitch_scale = get_pitch()
	play(from_position)
