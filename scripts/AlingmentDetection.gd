extends Area2D

@onready var AreaNode = $"."
@onready var ParentNode = $".".get_parent()
@export var DetectOnFront : bool
@export var Radius : float
@export var AngleDetection : float

var newPosition : Vector2
var newRotation : float
var activeSnapping = false
var snapChannel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var circle : CircleShape2D = $CollisionShape2D["shape"]
	circle.set_radius(Radius)
	$CollisionShape2D["shape"] = circle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !ParentNode["active"] && activeSnapping:
		ParentNode.global_position = newPosition
		ParentNode.global_rotation = newRotation
		GlobalScreenChanger.callSnappingEvent(snapChannel)
		activeSnapping = false


func _on_area_entered(area: Area2D) -> void:
	if ParentNode["active"] && !ParentNode["flipping"] && ParentNode["front"] == DetectOnFront:
		if deg_to_rad(AngleDetection) >= abs(AreaNode.global_rotation - area.global_rotation):
			var posDif : Vector2 = AreaNode.global_position - ParentNode.global_position
			var angleDif : float = - AreaNode.global_rotation + area.global_rotation
			newPosition = area.global_position - posDif.rotated(angleDif)
			newRotation = ParentNode.global_rotation + angleDif
			snapChannel = AreaNode.collision_mask
			activeSnapping = true


func _on_area_exited(area: Area2D) -> void:
	activeSnapping = false
