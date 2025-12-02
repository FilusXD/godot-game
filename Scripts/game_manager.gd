extends Node

var current_area = 1
var area_path = "res://Areas/"

var blue_fire = 0

func _ready():
	reset_fire()

func next_level():
	current_area += 1
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	print("Player has moved to area " + str(current_area))
	set_up_area()

func set_up_area():
	reset_fire()

func add_fire():
	blue_fire += 1
	if blue_fire >= 4:
		var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
		portal.open()


func reset_fire():
	blue_fire = 0
