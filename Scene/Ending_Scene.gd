extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var ending_name = get_highest_ending()
	$ED.play(ending_name)
	if(Global.language == "English"):
		$End_text.setText("You got the " + ending_name + " ending!")
	elif(Global.language == "Japanese"):
		var JP_ending_text = ""
		match(ending_name):
			"artist": 
				JP_ending_text = "エンディング２：芸術家"
			"musician": 
				JP_ending_text = "エンディング４：音楽家"
			"scientist": 
				JP_ending_text = "エンディング５：科学者"
			"archeologist": 
				JP_ending_text = "エンディング１：考古学者"
			"empty":
				JP_ending_text = "エンディング３：虚無"
		$End_text.setText(JP_ending_text)
	pass # Replace with function body.

func get_highest_ending() -> String:
	var highest_points = 0
	var ending_name = ""
	var points = Array(Global.totals.values())
	var endings = Array(Global.totals.keys())
	for i in endings.size():
		if(highest_points < points[i]):
			highest_points = points[i]
			ending_name = endings[i]
	if(highest_points == 0):
		MusicController.play_music("nothing")
		return "empty"
	
	match(ending_name):
		"artist_points": 
			return "artist"
		"musician_points": 
			return "musician"
		"scientist_points": 
			return "scientist"
		"archeologist_points": 
			return "archeologist"
	return "empty"

func _on_Button_pressed():
	#reset global totals
	var keys = Array(Global.totals.keys())
	for key in keys:
		Global.totals[key] = 0
		#print(key + " is now " + str(Global.totals[key]))
	get_tree().change_scene("res://Scene/Start.tscn")
