extends Area2D

@onready var paperdocument : Area2D = $"."
@onready var animation_tree : AnimationTree = $AnimationTree

var active = false
var mouse_paper = Vector2(0, 0)
var paper_mouse_dir = Vector2(0, 0)
var rotation0 = 0.0
var rotationMult = 0.0
var flipping = false
var front = true

func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	var new_paper_mouse = mouse_position - paperdocument.get_global_position()
	var new_paper_mouse_dir = new_paper_mouse.normalized()
	var to_rotate = acos(paper_mouse_dir.dot(new_paper_mouse_dir))*sign(paper_mouse_dir.cross(new_paper_mouse_dir))
	if flipping:
	# Activation of animation of getting flipped
		animation_tree["parameters/conditions/flip"] = front
		animation_tree["parameters/conditions/flip back"] = !front
		flipping = false
	if active:	
	# Generic dragging with mouse
		mouse_paper = mouse_paper.rotated(to_rotate * rotationMult)
		paperdocument.rotation = rotation0 + to_rotate * rotationMult
		paperdocument.global_position = mouse_position + mouse_paper
		mouse_paper = paperdocument.get_global_position() - get_viewport().get_mouse_position()
		paper_mouse_dir = -mouse_paper
		paper_mouse_dir = paper_mouse_dir.normalized()
		rotation0 = paperdocument.rotation
	# Generic dragging with mouse
	#	mouse_paper = mouse_paper.rotated(to_rotate)
	#	paperdocument.rotation = rot + to_rotate
	#	paperdocument.global_position = mouse_position + mouse_paper
	#	mouse_paper = paperdocument.get_global_position() - get_viewport().get_mouse_position()
	#	paper_mouse_dir = -mouse_paper
	#	paper_mouse_dir = paper_mouse_dir.normalized()
	#	rot = paperdocument.rotation
	# For pure rotation with mouse
	#	paperdocument.rotation = rot+acos(paper_mouse_dir.dot(new_paper_mouse_dir))*sign(paper_mouse_dir.cross(new_paper_mouse_dir))
	# For pure translation with mouse
	#	paperdocument.global_position = mouse_position + mouse_paper

func _on_button_button_down() -> void:
	paperdocument.move_to_front()
	rotation0 = paperdocument.rotation
	if Input.get_mouse_button_mask() == 1:
		mouse_paper = paperdocument.get_global_position() - get_viewport().get_mouse_position()
		paper_mouse_dir = -mouse_paper
		paper_mouse_dir = paper_mouse_dir.normalized()
		var size = $Button.size
		rotationMult = 2 * mouse_paper.length() / size.length()
		rotationMult = 2 * rotationMult * rotationMult
		active = true
	else:
		flipping = true
		front = !front

func _on_button_button_up() -> void:
	active = false

func _on_mouse_shape_entered(shape_idx: int) -> void:
	pass # Replace with function body.

	#if event is InputEventMouseButton:
	#	target = get_global_mouse_position()
	#	look_at(target)
