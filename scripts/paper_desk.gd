extends Node2D

@onready var Background : Sprite2D = $Background
var sumOfActiveIds : int = 0
var activeLightPower = false

func callSnappingEvent(id: int):
	# Called when a snapping happen the id is the sum of the collision mask
	# To translate from list of mask to id is:
	# id = sum(pow(2,mask-1))
	# for example a mask = {1,2,3} has id = 7
	if id == 0:
		return
	if fmod(log(float(id))/log(2.0),1.0) != 0:
		return
	sumOfActiveIds = sumOfActiveIds^id
	var toggle = (sumOfActiveIds&id)>0
	match id:
		2:
			#When the Light sigil it's on
			$Starsheet/Back/LightSign.visible = toggle
			$Background.newTransition(Color("3b7fd7"),20)
			if toggle:
				Manager.soundToPlay("TurnOnLightSigil")
				Manager.soundToPlay("NormalHearthBeat")
			else:
				Manager.soundToPlay("TurnOffLightSigil")
				$Church/Back/WithLight.visible = false
				$Church/Front/WithLight.visible = false
				$Church/Front/DetectLight.visible = false
				$Church/Front/DetectBell.visible = false
				if $Starsheet/Back/LightSign.button_pressed:
					$Starsheet/Back/LightSign.button_pressed = false
					activeLightPower = false
				

var closing = false
var postclosing = false
var rotationFolder:float
var positionFolder:Vector2
var transitionTime = 1.0
var positionFinal = Vector2(960*0.6,540*0.6)
var rotationFinal = 0.0
func _process(delta: float) -> void:
	if closing:
		$Folder.global_position = lerp(positionFinal+Vector2(-283*0.6,0),positionFolder,transitionTime)
		$Folder.global_rotation = lerp(rotationFinal,rotationFolder,transitionTime)
		transitionTime -= delta
		if transitionTime <= 0:
			$Folder.global_position = positionFinal+Vector2(-283*0.6,0)
			$Folder.global_rotation = rotationFinal
			closing = false
			postclosing = true
	if postclosing:
		$AnimationTree["parameters/conditions/Closing"] = true
		$Folder.animation_tree["parameters/conditions/End"] = true
	


func _on_menu_closing_animation() -> void:
	$Background.newTransition(Color("4d76fd"), 2.0)
	$Starsheet.transitionMoveTo(positionFinal)
	$"Starlight Photograph".transitionMoveTo(positionFinal)
	$Church.transitionMoveTo(positionFinal)
	closing = true
	$Folder.flipping = true
	$Folder.front = true
	rotationFolder = $Folder.get_global_rotation()
	positionFolder = $Folder.get_global_position()
	if $Folder.scale.x <= 0:
		rotationFolder = rotationFolder - PI*sign(rotationFolder)
	


func _on_light_sign_button_down() -> void:
	activeLightPower = true
	$Church/Front/DetectLight.visible = true
	print("Received light")
	Manager.soundToPlay("Writing")


func _on_detect_light_button_down() -> void:
	if activeLightPower:
		$Church/Back/WithLight.visible = true
		$Church/Front/WithLight.visible = true
		$Church/Front/DetectBell.visible = true
		print("Send light")
		activeLightPower = false
		Manager.soundToPlay("Writing")

func _on_detect_bell_button_down() -> void:
	Manager.soundToPlay("BellRing")
	print("Sounds bell")
