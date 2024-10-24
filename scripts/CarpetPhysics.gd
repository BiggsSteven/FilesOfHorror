extends Node2D

@onready var mainfolder : Node2D = $"."
@onready var animation_tree : AnimationTree = $AnimationTree

var active = false
var flipping = false
var front = true
var outside = false
var alignToExit = false
var aligningToExit = false
var aligning = Vector2.ZERO
var centerLocation = Vector2(1960*0.6,1080*0.6)
var Center = Vector2.ZERO

var mouse_paper = Vector2.ZERO
var paper_mouse_dir = Vector2.ZERO
var rotation0 = 0.0
var rotationMult = 0.0
var transitionProgress = 0.0
var transitionTime = 1.0

func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	var new_paper_mouse = mouse_position - mainfolder.get_global_position()
	var new_paper_mouse_dir = new_paper_mouse.normalized()
	var to_rotate = acos(paper_mouse_dir.dot(new_paper_mouse_dir))*sign(paper_mouse_dir.cross(new_paper_mouse_dir))
	if  alignToExit && !aligningToExit:
		animation_tree["parameters/conditions/flip"] = false
		animation_tree["parameters/conditions/flip back"] = true
		rotation0 = mainfolder.get_global_rotation()
		if scale.x <= 0:
			rotation0 = rotation0 - PI*sign(rotation0)
		aligningToExit = true
	if aligningToExit:
		transitionProgress += _delta
		global_position = global_position+aligning*_delta/transitionTime
		if scale.x <= 0:
			global_rotation = PI+global_rotation-rotation0*_delta/transitionTime
		else:
			global_rotation = global_rotation-rotation0*_delta/transitionTime
		if transitionProgress >= transitionTime:
			aligningToExit = false
			alignToExit = false
	
	if flipping && !alignToExit:
	# Activation of animation of getting flipped
		animation_tree["parameters/conditions/flip"] = !front
		animation_tree["parameters/conditions/flip back"] = front
		flipping = false
		Manager.soundToPlay("PageFlip4")
	if active && !alignToExit:	
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
		Manager.soundToPlay("PageFlip5")
	else:
		flipping = true
		front = !front

func _on_main_carpet_button_up() -> void:
	if outside:
		mainfolder.global_position = centerLocation
		mainfolder.rotation = snappedf(rotation,2*PI/32)
	active = false

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	outside = true

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	outside = false


func _on_start_closing_animation() -> void:
	#$Settings.otherClosing = true
	$Credits.otherClosing = true
	$Quit.otherClosing = true
	alignToExit = true
	Center = centerLocation / 2 + Vector2(283*0.6,0)
	aligning = Center - mainfolder.get_global_position()

#func _on_settings_closing_animation() -> void:
#	$Start.otherClosing = true
#	$Credits.otherClosing = true
#	$Quit.otherClosing = true
#	alignToExit = true
#	Center = centerLocation / 2 + Vector2(283*0.6,0)
#	aligning = Center - mainfolder.get_global_position()

func _on_credits_closing_animation() -> void:
	$Credits.animation_tree["parameters/conditions/Disapear"] = false
	$Credits.PastInside = !$Credits.PastInside
	$Credits.Closing = false
	$Credits.otherClosing = false
	flipping = true
	front = !front
	alignToExit = true
	Center = centerLocation / 2
	aligning = Center - mainfolder.get_global_position()

func _on_quit_closing_animation() -> void:
	$Start.otherClosing = true
	$Credits.otherClosing = true
	#$Settings.otherClosing = true
	alignToExit = true
	Center = centerLocation / 2
	aligning = Center - mainfolder.get_global_position()
