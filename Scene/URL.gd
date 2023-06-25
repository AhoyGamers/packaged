extends RichTextLabel

export var url = "URL"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_URLPhil_gui_input(event):
	if event is InputEventMouseButton: #mouse user check
			if(event.is_pressed()):
				OS.shell_open(url)
	pass # Replace with function body.
