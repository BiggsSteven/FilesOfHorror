extends Area2D

@export var Front : Sprite2D
@export var FrontVisible : bool
@export var Back : Sprite2D
@export var BackVisible : bool
@onready var Paper : Area2D = $"."
@onready var Animation_Tree : AnimationTree = $AnimationTree
@onready var AreaDetection : CollisionShape2D = $CollisionShape2D
@onready var ScreenNotifier : VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var DetectClicking : TextureButton = $TextureButton

var active = false
var flipping = false
var front = true
var outside = false

var mouse_paper = Vector2(0, 0)
var paper_mouse_dir = Vector2(0, 0)
var mouse_velocity = Vector2(0, 0)
var rotation0 = 0.0
var rotationMult = 0.0

func _ready() -> void:
	if Front != null && Back != null:
		Front.position = Vector2(0,0)
		Back.position = Vector2(0,0)
		var size : Vector2 = Front.get_rect().size * Front.scale
		Back.scale = size / Back.get_rect().size
		AreaDetection.scale = size / AreaDetection.shape.get_rect().size
		ScreenNotifier.rect = Front.get_rect()
		DetectClicking.size = size
		DetectClicking.position = -size/2
	else:
		queue_free()

func _process(delta: float) -> void:
	Front.visible = FrontVisible
	Back.visible = BackVisible
	var mouse_position = get_viewport().get_mouse_position()
	var new_paper_mouse = mouse_position - Paper.get_global_position()
	var new_paper_mouse_dir = new_paper_mouse.normalized()
	var to_rotate = acos(paper_mouse_dir.dot(new_paper_mouse_dir))*sign(paper_mouse_dir.cross(new_paper_mouse_dir))
	if flipping:
	# Activation of animation of getting flipped
		Animation_Tree["parameters/conditions/Flip"] = front
		Animation_Tree["parameters/conditions/Flip Back"] = !front
		flipping = false
	if active:	
	# Generic dragging with mouse
		mouse_paper = mouse_paper.rotated(to_rotate * rotationMult)
		Paper.rotation = rotation0 + to_rotate * rotationMult
		Paper.global_position = mouse_position + mouse_paper
		mouse_paper = Paper.get_global_position() - get_viewport().get_mouse_position()
		paper_mouse_dir = -mouse_paper
		paper_mouse_dir = paper_mouse_dir.normalized()
		rotation0 = Paper.rotation

#func _input(event: InputEvent) -> void:
#	if event is InputEventMouseMotion:
#		mouse_velocity = event.screen_velocity

func _on_texture_button_button_down() -> void:
	Paper.move_to_front()
	rotation0 = Paper.rotation
	if Input.get_mouse_button_mask() == 1:
		mouse_paper = Paper.get_global_position() - get_viewport().get_mouse_position()
		paper_mouse_dir = -mouse_paper
		paper_mouse_dir = paper_mouse_dir.normalized()
		var size = DetectClicking.size
		rotationMult = 2 * mouse_paper.length() / size.length()
		rotationMult = 2 * rotationMult * rotationMult
		active = true
	else:
		flipping = true
		front = !front


func _on_texture_button_button_up() -> void:
	var screen = get_viewport().get_visible_rect()
	var screenCenter = screen.size / 2
	if outside:
		Paper.global_position = screenCenter
	active = false

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	outside = true

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	outside = false

func _on_mouse_shape_entered(shape_idx: int) -> void:
	# Tried to make paper move when mouse pass over them
	#var rotation = 0.000001*mouse_velocity.cross(Paper.get_global_position() - get_viewport().get_mouse_position())
	#Paper.rotate(rotation)
	pass
