extends Node2D
#sent out to delete any picked up items. 
#connected between Trash.gd -> Placement_Object.gd
#and Trash.gd -> [host scene of each level]
signal delete() 

var mouse_on_obj = false

# Called when the node enters the scene tree for the first time.
func _input(event):
			if event is InputEventMouseButton: #mouse user check
				if(event.is_pressed()):
					if(mouse_on_obj):
						emit_signal("delete")
						Global.player_holding_obj = false


func _on_Area2D_mouse_entered():
	$Can.play("Open")
	mouse_on_obj = true
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	$Can.play("Closed")
	mouse_on_obj = false
	pass # Replace with function body.
