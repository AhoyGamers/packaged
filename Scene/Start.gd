extends Node2D

var creds_visible = false
var child_music = load("res://sounds/child.mp3")

func _ready():
	MusicController.play_music("child_music")

func _on_Button_pressed():
	if(creds_visible):
		$CreditsAnim.play("MoveOutCreds")
	
	$AnimationPlayer.play("FadeInKid")
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	print("Changing scene!")
	get_tree().change_scene("res://Scene/ChildCG.tscn")
	pass # Replace with function body.


func _on_Credits_pressed():
	if(creds_visible):
		$CreditsAnim.play("MoveOutCreds")
	else:
		$CreditsAnim.play("MoveInCreds")
	creds_visible = !creds_visible
	pass # Replace with function body.
