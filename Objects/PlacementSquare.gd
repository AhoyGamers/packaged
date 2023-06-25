extends Node2D
#used for squares within the containers, checks if taken or not
signal trying_to_place(valid) #sent out when the player tries to place
						 #item, and whether it is valid to do so.
						#connected to square Overlay so it turns on/off.
var taken = false

#what object is this holding? Used when objects are picked up 
#to determine if taken
var held_object = "none" 

func _ready():
	Global.connect("player_placed_object", self, "_on_Global_player_place_object")
	pass
	#print("Hi there!")

#when player places or picks up an object, make it green or red
#depending on if it is a valid placement option
func _on_Global_player_place_object(picked_up, obj_name):
	if(obj_name == held_object):
		if(picked_up):
			#print("PlacementSquare: Player picked up" + obj_name)
			held_object = "none"
			taken = false
		else:
			#print("PlacementSquare: Player has placed " + obj_name)
			$Square/Overlay.visible = false;
			taken = true
	show_taken_obj(picked_up)

#show invalid grids that are taken by objects
func show_taken_obj(picked_up_an_obj):
	#when player picks up object, let them know which grids are invalid
	if(picked_up_an_obj): 
		if(taken):
			$Square/Overlay.modulate = Color(1, 0, 0) #make overlay red
			$Square/Overlay.visible = true;
		else:
			$Square/Overlay.modulate = Color(0, 1, 0) #make overlay green
	else:
		$Square/Overlay.visible = false;

func _on_Area2D_area_entered(area):
	if(area.is_in_group("object")):
		$Square/Overlay.visible = true;
		#print("PlacementSquare: I am touching " + obj_name) 
		#send out if overlay should be green (taken=false), or red (taken=true)
		if(taken):
			$Square/Overlay.modulate = Color(1, 0, 0) #make overlay red
		else:
			var obj_name = area.get_parent().get_parent().get_parent().name
			held_object = obj_name
			$Square/Overlay.modulate = Color(0, 1, 0) #make overlay green


#remove overlay if not touching anything
func _on_Area2D_area_exited(area):
	var touchedGrids = $Area2D.get_overlapping_areas()
	if(touchedGrids.size() == 0):
		held_object = "none"
		$Square/Overlay.visible = false;
	
