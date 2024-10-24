extends Node2D

@export_enum("BellRing","TurnOnLightSigil","TurnOffLightSigil","NormalHearthBeat","SpeedyHearthBeat","PageFlip1","PageFlip2","PageFlip3","PageFlip4","PageFlip5","Writing") var soundToPlay:String

func _on_button_pressed() -> void:
	Manager.soundToPlay(soundToPlay)
#Manager.soundToPlay("BellRing")
#Manager.soundToPlay("TurnOnLightSigil")
#Manager.soundToPlay("TurnOffLightSigil")
#Manager.soundToPlay("NormalHearthBeat")
#Manager.soundToPlay("SpeedyHearthBeat")
#Manager.soundToPlay("PageFlip1")
#Manager.soundToPlay("PageFlip2")
#Manager.soundToPlay("PageFlip3")
#Manager.soundToPlay("PageFlip4")
#Manager.soundToPlay("PageFlip5")
#Manager.soundToPlay("Writing")
