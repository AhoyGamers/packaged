extends Node2D

# Called when the node enters the scene tree for the first time.
func begin():
	get_tree().change_scene("res://Scene/Start.tscn")


func _on_English_Button_pressed():
	Global.language = "English"
	begin()



func _on_JP_Button_pressed():
	Global.language = "Japanese"
	begin()
