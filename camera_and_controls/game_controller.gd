extends Node

class_name GameController

@export var save_handler: SaveAndLoad

var tiles = {}
var characters = {}
var selected_character: Character
var hovered_tile: Tile

#Character state
var char_index := 0
var movementHighlighted := false
var canMove := true
var isMoving := false
var done := false

func _ready() -> void:
	characters = get_chars_by_initiative()
	selected_character = characters[char_index]

func _process(delta: float) -> void:
	if(canMove && selected_character && !movementHighlighted):
		selected_character.highlight_movable_tiles()
		movementHighlighted = true
	if(isMoving):
		isMoving = selected_character.is_moving
		if(!isMoving):
			done = true
	if(done):
		if(char_index < characters.size()-1):
			char_index += 1
		else:
			char_index = 0
		selected_character = characters[char_index]
		done = false
		movementHighlighted = false
		canMove = true

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
	pass
	
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
	if(selected_character && canMove && (selected_character.currentTile == null || hovered_tile.get_movable())):
		selected_character.assignTile(hovered_tile)
		canMove = false
		isMoving = true
	
func hover_default() -> void:
	if(hovered_tile):
		hovered_tile.is_hovered(false)
	hovered_tile = null
	
func get_chars_by_initiative() -> Array[Node]:
	var chars_in_scene := get_tree().get_nodes_in_group("Character")
	chars_in_scene.sort_custom(func(a, b): return a.initiative > b.initiative)
	return chars_in_scene
