extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()



func _on_start_button_pressed():
	print("Start Button Pressed");
	#get_tree().change_scene("res://Levels/Level_0.tscn");


func _on_options_button_pressed():
	print("Options Button Pressed"); # Replace with function body.


func _on_quit_button_pressed():
	print("Quit Button Pressed");
	get_tree().quit();
