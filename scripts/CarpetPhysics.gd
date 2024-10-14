extends Node2D

@onready var mainfolder : Node2D = $"."
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
	var new_paper_mouse = mouse_position - mainfolder.get_global_position()
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
		mainfolder.rotation = rotation0 + to_rotate * rotationMult
		mainfolder.global_position = mouse_position + mouse_paper
		mouse_paper = mainfolder.get_global_position() - get_viewport().get_mouse_position()
		paper_mouse_dir = -mouse_paper
		paper_mouse_dir = paper_mouse_dir.normalized()
		rotation0 = mainfolder.rotation
	# Generic dragging with mouse
	#	mouse_paper = mouse_paper.rotated(to_rotate)
	#	mainfolder.rotation = rot + to_rotate
	#	mainfolder.global_position = mouse_position + mouse_paper
	#	mouse_paper = mainfolder.get_global_position() - get_viewport().get_mouse_position()
	#	paper_mouse_dir = -mouse_paper
	#	paper_mouse_dir = paper_mouse_dir.normalized()
	#	rot = mainfolder.rotation
	# For pure rotation with mouse
	#	mainfolder.rotation = rot+acos(paper_mouse_dir.dot(new_paper_mouse_dir))*sign(paper_mouse_dir.cross(new_paper_mouse_dir))
	# For pure translation with mouse
	#	mainfolder.global_position = mouse_position + mouse_paper

func _on_main_carpet_button_down() -> void:
	rotation0 = mainfolder.rotation
	if Input.get_mouse_button_mask() == 1:
		mouse_paper = mainfolder.get_global_position() - get_viewport().get_mouse_position()
		paper_mouse_dir = -mouse_paper
		paper_mouse_dir = paper_mouse_dir.normalized()
		var size = $Button.size
		rotationMult = 2 * mouse_paper.length() / size.length()
		rotationMult = 2 * rotationMult * rotationMult
		active = true
	else:
		flipping = true
		front = !front

func _on_main_carpet_button_up() -> void:
	active = false
