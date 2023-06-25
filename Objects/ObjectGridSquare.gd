extends Node2D

#don't use me

# Called when the node enters the scene tree for the first time.
func _process(delta):
	#move_to_mouse()
	pass

func move_to_mouse():
	self.global_position = get_global_mouse_position()

