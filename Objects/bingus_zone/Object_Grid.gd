extends TileMap

onready var container_square = preload("res://Objects/ObjectGridSquare.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var cells = get_used_cells_by_id(0) #returns an array cells that use tile 0
	add_cells(cells)

func add_cells(array):
	var pos
	#iterate through the array of cells, attaching an instance
	#to each cell we passed in.
	for i in range(0, array.size()):
		pos = map_to_world(array[i])
		var cell = container_square.instance()
		add_child(cell)
		cell.set_position(Vector2(pos.x+30,pos.y+30))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
