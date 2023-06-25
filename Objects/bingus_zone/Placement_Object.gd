extends Node2D
#the code for the entire object with multiple grid squares
var picked_up = false
var mouse_on_obj = false
var is_packed = false


#the characteristics that determine each ending
export var characteristics = {
	"artist_points": 0,
	"musician_points": 0,
	"scientist_points": 0,
	"archeologist_points": 0
}

func _ready():
	get_parent().get_node("Trash").connect("delete", self, "_on_trash_delete")

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if(picked_up):
		move_to_mouse()

func togglePickUp():
	picked_up = !picked_up
	Global.player_holding_obj = picked_up
	Global.emit_signal("player_placed_object",picked_up, name)

func _input(event):
	if(mouse_on_obj):
		#during placement, check if player has clicked. If so, place the blaster in its spot
		if event is InputEventMouseButton: #mouse user check
			if(event.is_pressed()):
					if(picked_up):
						attempt_to_place()
					elif(!Global.player_holding_obj):
						togglePickUp()

#check if the currently held object can be placed
func attempt_to_place():
	#get the overlapping areas that are touching the object
	
	#get how many squares big the obj is
	var obj_size = $Grid.get_child_count()
	
	var touched_areas = $Area2D.get_overlapping_areas().size()
	#how many grid spaces is the object touching?
	var touched_grid_spaces = get_num_of_grid_space_areas()
	
	#print("There are " + str(touched_grid_spaces) + " touched grid spaces and " + str(obj_size) + " object grid spaces.")
	
	if(touched_areas > 1): #if it is touching every grid space
		if(touched_grid_spaces == obj_size): #if at least one part of the object is within the grid
			#if no grid spaces are taken, allow placement
			if(!grid_areas_taken()): #place area in grid
				#print("No grid areas taken!")
				is_packed = true
				togglePickUp()
			else:
				#print("Placement_Object: Can't place because grid area taken!")
				#maybe play a "cannot place" sfx here?
				pass
		elif(touched_grid_spaces == 0): #place area outside of grid
			is_packed = false
			togglePickUp()
			#print("Placement_Object: Can't place because obj completely outside grid!")
	else:
		#print("Placement_Object: Can't place because a part of obj outside grid!")
		pass
		#print("Placement_Object: Can't place because obj not touching anything!!")
	pass

#checks each object square in the object and checks if any of them are touching a grid space
func get_num_of_grid_space_areas() -> int:
	var obj_squares = $Grid.get_children()
	var squares_in_grid = 0
	for cur_obj_square in obj_squares:
		var touched_areas = cur_obj_square.get_node("Area2D").get_overlapping_areas()
		for area in touched_areas:
			if(area.is_in_group("GridSquare")):
				squares_in_grid+=1
	return squares_in_grid

#loops through each of the touched grid objects to see if any of them are taken
func grid_areas_taken() -> bool:
	var obj_squares = $Grid.get_children()
	var squares_in_grid = 0
	for cur_obj_square in obj_squares:
		var touched_areas = cur_obj_square.get_node("Area2D").get_overlapping_areas()
		for area in touched_areas:
			if(area.is_in_group("GridSquare")):
				if(area.get_parent().taken):
					return true
	return false

#if the object is dragged to the trash, it should delete itself.
#TODO: play delete sfx?
func _on_trash_delete():
	#print("Placement_object: trash delete signal received!")
	if(picked_up):
		self.queue_free()
		#emit signal so the game_scene.gd still runs its checker program
		Global.emit_signal("player_placed_object",false, name)

#move to mouse with grid-like motion
func move_to_mouse():
	#move to the nearest x and y coordinates divisible by 60,
	#use 60 because that's the size of each grid space
	var pos = get_global_mouse_position()
	self.global_position = Vector2(60*floor(pos.x/60),60*floor(pos.y/60))

func get_characteristics() -> Dictionary:
	return characteristics

func _on_Area2D_mouse_entered():
	mouse_on_obj = true

func _on_Area2D_mouse_exited():
	mouse_on_obj = false

#weird stuff to make sure when objs are deleted they aren't counted in game_scene.gd
func _on_Area2D_area_entered(area):
	if(area.is_in_group("trash")):
		is_packed = true

func _on_Area2D_area_exited(area):
	if(area.is_in_group("trash")):
		is_packed = false
