extends Node

class_name GameController

@export var save_handler: SaveAndLoad

var tiles = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if(Input.is_action_just_pressed("one")):
		save_handler.save_scene()
	if(Input.is_action_just_pressed("two")):
		save_handler.load_scene()

func map_tiles() -> void:
	var tiles_in_scene := get_tree().get_nodes_in_group("Tile")
	for tile in tiles_in_scene:
		var new_key = get_key_from_tile(tile)
		if(tiles.has(new_key)):
			print("ERROR! duplicate tiles at " + new_key)
		else:
			tiles[new_key] = tile
	
func get_key_from_tile(tile: Tile) -> String:
	return str(tile.global_position.x) + "," + str(tile.global_position.z) + "," + str(tile.level)
