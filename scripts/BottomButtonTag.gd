extends Node2D

@onready var animation_tree : AnimationTree = $AnimationTree

var Inside = false
var PastInside = false

func _process(delta: float) -> void:
	if Inside != PastInside:
		animation_tree["parameters/conditions/Show"] = Inside
		animation_tree["parameters/conditions/UnShow"] = !Inside
		PastInside = Inside

func _on_detect_entry_mouse_entered() -> void:
	Inside = true

func _on_detect_exit_mouse_exited() -> void:
	Inside = false

func _on_button_button_down() -> void:
	var tabName = get_node("Tab/Sprite2D/Label").text
	GlobalScreenChanger.callChangeScene(tabName)
