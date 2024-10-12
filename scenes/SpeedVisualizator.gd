extends Polygon2D

var speed = Vector2(1,1)

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	speed = Input.get_last_mouse_velocity()/100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale=speed
	pass
