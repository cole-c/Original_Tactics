extends Node

var tiles = {}

#TODO: 
	#working on mapping tiles into an easily referencable structure here
	#Next steps: use this struct + character's movement to highlight moveable tiles
	#move only to a moveable tile on click
	#Move between tiles one at a time with a pathfinding algorithm

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
