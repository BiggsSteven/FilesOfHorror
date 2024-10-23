extends Node2D

@export var texture : Texture2D
@onready var animation_tree : AnimationTree = $AnimationTree
signal closingAnimation

var Inside = false
var PastInside = false
var Closing = false
var otherClosing = false

func _ready() -> void:
	if texture != null:
		$Sprite2D.texture = texture

func _process(delta: float) -> void:
	if Inside != PastInside && !Closing:
		animation_tree["parameters/conditions/Show"] = Inside
		animation_tree["parameters/conditions/UnShow"] = !Inside
		PastInside = Inside
	if Closing && !otherClosing:
		animation_tree["parameters/conditions/Show"] = true
		animation_tree["parameters/conditions/UnShow"] = false
		animation_tree["parameters/conditions/Disapear"] = true
		emit_signal("closingAnimation")
		otherClosing = true
	if !Closing && otherClosing:
		animation_tree["parameters/conditions/Show"] = false
		animation_tree["parameters/conditions/UnShow"] = true
		animation_tree["parameters/conditions/Hide"] = true
		Closing = true

func _on_detect_entry_mouse_entered() -> void:
	Inside = true

func _on_detect_exit_mouse_exited() -> void:
	Inside = false

func _on_button_button_down() -> void:
	Closing = true

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Disapear":
		GlobalScreenChanger.callChangeScene($".".name)
