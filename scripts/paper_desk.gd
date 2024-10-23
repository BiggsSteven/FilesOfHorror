extends Node2D

func callSnappingEvent(id: int):
	
	# Called when a snapping happen the id is the sum of the collision mask
	# To translate from list of mask to id is:
	# id = sum(pow(2,mask-1))
	# for example a mask = {1,2,3} has id = 7
	match id:
		2:
			#When the Light sigil it's on
			$Starsheet/LightSign.visible = true
			$Church/Back/WithLight.visible = true
			$Church/Front/WithLight.visible = true
