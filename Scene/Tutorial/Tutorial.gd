extends Node2D
export(String) var next_level = "res"

func _on_NextButton_pressed():
	get_tree().change_scene(next_level)
	pass # Replace with function body.
