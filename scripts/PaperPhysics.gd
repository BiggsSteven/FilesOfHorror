extends Area2D

var active = false
var mouse_paper = Vector2(0, 0)
var paper_mouse_dir = Vector2(0, 0)
var rot = 0.0

func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	var new_paper_mouse = mouse_position - $".".get_global_position()
	var new_paper_mouse_dir = new_paper_mouse.normalized()
	if active:	
	# Generic dragging with mouse
		mouse_paper = mouse_paper.rotated(acos(paper_mouse_dir.dot(new_paper_mouse_dir))*sign(paper_mouse_dir.cross(new_paper_mouse_dir)))
		$".".rotation = rot+acos(paper_mouse_dir.dot(new_paper_mouse_dir))*sign(paper_mouse_dir.cross(new_paper_mouse_dir))
		$".".global_position = mouse_position + mouse_paper
		mouse_paper = $".".get_global_position() - get_viewport().get_mouse_position()
		paper_mouse_dir = -mouse_paper
		paper_mouse_dir = paper_mouse_dir.normalized()
		rot = $".".rotation
	# For pure rotation with mouse
	#	$".".rotation = rot+acos(paper_mouse_dir.dot(new_paper_mouse_dir))*sign(paper_mouse_dir.cross(new_paper_mouse_dir))
	# For pure translation with mouse
	#	$".".global_position = mouse_position + mouse_paper

func _on_button_button_down() -> void:
	$".".move_to_front()
	mouse_paper = $".".get_global_position() - get_viewport().get_mouse_position()
	paper_mouse_dir = -mouse_paper
	paper_mouse_dir = paper_mouse_dir.normalized()
	rot = $".".rotation
	active = true

func _on_button_button_up() -> void:
	active = false

func _on_mouse_shape_entered(shape_idx: int) -> void:
	pass # Replace with function body.

	#if event is InputEventMouseButton:
	#	target = get_global_mouse_position()
	#	look_at(target)
