extends Area2D

var totals = {
	"artist_points": 0,
	"musician_points": 0,
	"scientist_points": 0,
	"archeologist_points": 0
}

func get_points() -> Dictionary:
	#find all areas of type object
	var objects = []
	#get all of the objects within the packing area
	for area in self.get_overlapping_areas():
		if(area.is_in_group("object")):
			var candidate = area.get_parent().get_parent().get_parent()
			if(!objects.has(candidate) && candidate.name != "root"): #prevent duplicates
				objects.append(candidate)
		
	for object in objects:
		print(object.name)
		var object_characteristics = object.get_characteristics()
		print(str(object_characteristics))
		totals.artist_points += object_characteristics.artist_points
		totals.musician_points += object_characteristics.musician_points
		totals.scientist_points += object_characteristics.scientist_points
		totals.archeologist_points += object_characteristics.archeologist_points
	return totals
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
