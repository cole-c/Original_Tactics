extends Node

class_name GameController

@export var save_handler: SaveAndLoad

var tiles = {}
var selected_character: Character
var hovered_tile: Tile

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
	
func click_character(character: Character) -> void:
	#TODO this is a work around until the game controller assigns a tile on character spawn, etc
	if(selected_character && selected_character != character):
		selected_character.clear_movable_tiles()
	selected_character = character
	selected_character.highlight_movable_tiles()
	
func hover_tile(tile: Tile) -> void:
	var new_hovered_tile = tile
	if(!hovered_tile):
		hovered_tile = new_hovered_tile
	if(new_hovered_tile != hovered_tile):
		hovered_tile.is_hovered(false)
		hovered_tile = new_hovered_tile
	if(hovered_tile.get_movable()):
		hovered_tile.is_hovered(true)
	
func click_tile(tile: Tile) -> void:
	if(selected_character && (selected_character.currentTile == null || hovered_tile.get_movable())):
		#TODO AssignTile currently can set or move between current and new tiles, eventually split these up and the game controller will set tiles on spawn for characters
		selected_character.assignTile(hovered_tile)
	
func hover_default() -> void:
	if(hovered_tile):
		hovered_tile.is_hovered(false)
	hovered_tile = null
