extends Node2D

@onready var mainfolder : Node2D = $"."
@onready var animation_tree : AnimationTree = $AnimationTree

var active = false
var flipping = false
var front = true
var outside = false

var mouse_paper = Vector2(0, 0)
var paper_mouse_dir = Vector2(0, 0)
var rotation0 = 0.0
var rotationMult = 0.0

func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	var new_paper_mouse = mouse_position - mainfolder.get_global_position()
	var new_paper_mouse_dir = new_paper_mouse.normalized()
	var to_rotate = acos(paper_mouse_dir.dot(new_paper_mouse_dir))*sign(paper_mouse_dir.cross(new_paper_mouse_dir))
	if flipping:
	# Activation of animation of getting flipped
		animation_tree["parameters/conditions/Flip"] = front
		animation_tree["parameters/conditions/Flip Back"] = !front
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

func _on_button_button_down() -> void:
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

func _on_button_button_up() -> void:
	var screen = get_viewport().get_visible_rect()
	var screenCenter = screen.size / 2
	if outside:
		mainfolder.global_position = screenCenter
		mainfolder.rotation = snappedf(rotation,2*PI/32)
	active = false

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	outside = true

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	outside = false
