extends Sprite2D

@export var TransitionColorStart : Color = Color("8e76e1")
@export var TransitionColorEnd : Color = Color("8e76e1")
@export var TransitionSeconds : float = 1.0
var TransitionedTime = 0

func _process(delta: float) -> void:
	if TransitionedTime < TransitionSeconds:
		TransitionedTime += delta
	modulate = lerp(TransitionColorStart,TransitionColorEnd,TransitionedTime/TransitionSeconds)
