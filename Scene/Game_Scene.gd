extends Node2D
#sent out when all objects packed
#connected between Game_Scene and and RichtextLabel in scene
signal end_level(total)

export(String) var next_level = "res"
export(String) var music = "child_music"

func _ready():
	Global.connect("player_placed_object", self, "_on_Global_player_place_object")
	MusicController.play_music(music)

#get the total points and update the global dictionary
func get_points() -> Dictionary:
	var totals = $Packing_area.get_points()
	return totals
	#print(str(totals))

func update_global_dictionary(totals):
	Global.totals.artist_points += totals.artist_points
	Global.totals.musician_points += totals.musician_points
	Global.totals.scientist_points += totals.scientist_points
	Global.totals.archeologist_points += totals.archeologist_points

#see how many items remain unpacked, if all packed then go to next level!
func check_remaining_objects():
	var all_objects_packed = true
	var objects = Global.getObjectsInGroup("object", self)
	for object in objects:
		if(!object.is_packed):
			all_objects_packed = false
	if(all_objects_packed):
		transition_to_next_level()
	else:
		#print("Objects still need packing!")
		pass
	pass

func transition_to_next_level():
	var totals = get_points()
	update_global_dictionary(totals)
	emit_signal("end_level",totals)
	$AnimationPlayer.play("FadeInFinal")
	#print("All objects packed!")

func _on_Global_player_place_object(picked_up,obj_name):
	if(!picked_up):
		check_remaining_objects()

func _on_Trash_delete():
	check_remaining_objects()

func _on_NextLevelButton_pressed():
	get_tree().change_scene(next_level)

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene(next_level)
	pass # Replace with function body.
