extends Node
var player_holding_obj := false

var language = "English"

#connected between placement_object to placementSquare. 
#is_placing = is the player placing the object or picking it up?
#obj_group = used to give or take away obj name from placementSquare
#connected between placement_object and Game_Scene.gd
#is_placing = is the player placing the object or picking it up?
#when object placed the scene will see if no other objects need placing
signal player_placed_object(picked_up,obj_name)

#connected between placementSquare to placement_object. 
#states if the currently picked up obj can be placed
#valid - is the current spot valid
#obj_name - used to see if the correct object is checking its location
signal check_placement(valid, obj_name)

#emitted when player changes language
#attached to LanguageSwapper
signal language_changed()


#****functions
func getObjectsInGroup(groupName: String, scene: Node2D) -> Array:
	var sceneChildren:= scene.get_children()
	var groupObjects:= []
	for child in sceneChildren:
		if child.is_in_group(groupName):
			groupObjects.append(child)
	return groupObjects
	
#*************

#****variables
var totals = {
	"artist_points": 0,
	"musician_points": 0,
	"scientist_points": 0,
	"archeologist_points": 0
}
#*************
