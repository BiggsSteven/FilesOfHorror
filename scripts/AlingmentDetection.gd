extends Area2D

@onready var AreaNode = $"."
@onready var ParentNode = $".".get_parent()
@export var DetectOnFront : bool
@export var AngleDetection : float

var newPosition : Vector2
var newRotation : float
var activeSnapping = false
var snapped = false
var snapChannel = 0

func _process(delta: float) -> void:
	if activeSnapping:
		if !ParentNode["active"] && !snapped:
			ParentNode.global_position = newPosition
			ParentNode.global_rotation = newRotation
			snapped = true
			GlobalScreenChanger.callSnappingEvent(snapChannel)
			print("Snapped")
		if ParentNode["active"] && snapped:
			snapped = false

func _on_area_entered(area: Area2D) -> void:
	var parentActive = false
	var parentFlipping = false
	var parentFront = DetectOnFront
	if ParentNode["active"] != null: parentActive = ParentNode["active"]
	if ParentNode["flipping"] != null: parentFlipping = ParentNode["flipping"]
	if ParentNode["front"] != null: parentFront = ParentNode["front"]
	if parentActive && !parentFlipping && parentFront == DetectOnFront:
		print("Snapping Active")
		if deg_to_rad(AngleDetection)/2 >= abs(AreaNode.global_rotation - area.global_rotation):
			var posDif : Vector2 = AreaNode.global_position - ParentNode.global_position
			var angleDif : float = - AreaNode.global_rotation + area.global_rotation
			if !DetectOnFront: 
				posDif = -posDif
				angleDif = angleDif + PI
			newPosition = area.global_position - posDif.rotated(angleDif)
			newRotation = ParentNode.global_rotation + angleDif
			snapChannel = AreaNode.collision_mask
			activeSnapping = true
			print("Detected Snapping")

func _on_area_exited(area: Area2D) -> void:
	activeSnapping = false
