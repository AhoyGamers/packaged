extends Node

var child_music = load("res://sounds/child.wav")
var teen_music = load("res://sounds/teen.wav")
var adult_music = load("res://sounds/adult.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music(file):
	var matched = false
	match file:
		"child_music":
			$Music.stream = child_music
			matched = true
		"teen_music":
			$Music.stream = teen_music
			matched = true
		"adult_music":
			$Music.stream = adult_music
			matched = true
		"nothing":
			$Music.stop()
	if(matched):
		$Music.play()
