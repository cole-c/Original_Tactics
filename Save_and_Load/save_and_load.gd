extends Node

class_name SaveAndLoad

@export var fileName: String = "testMap.JSON"
@export var tile_scene: PackedScene

var savePath: String = "res://Save_and_Load/SavedFiles/"
var tiles = []

func save_scene():
	var saveFile = savePath + fileName
	save_map(saveFile)

func load_scene():
	var saveFile = savePath + fileName
	load_map(saveFile)

func save_map(saveFile):
	var main_dict = {
		"version": "Alpha",
		"tiles": []
	}
	
	get_tiles()
	
	for tile in tiles:
		var save_dict = {
			"pos_x" : tile.global_position.x,
			"pos_y" : tile.global_position.y,
			"pos_z" : tile.global_position.z
		}
		main_dict["tiles"].append(save_dict)
	
	var save_game = FileAccess.open(saveFile, FileAccess.WRITE)
	
	var json_string = JSON.stringify(main_dict, "\t", false)
	save_game.store_line(json_string)
	
func load_map(saveFile) -> void:
	if not FileAccess.file_exists(saveFile):
		print("Error! Save file not found")
		return
	
	var save_game = FileAccess.open(saveFile, FileAccess.READ)
	
	var json_text = save_game.get_as_text()
	var json = JSON.new()
	var parse_result = json.parse(json_text)
	
	if parse_result != OK:
		print("Error %s reading json file" % parse_result)
		return
	
	clear()
	
	var data = {}
	data = json.get_data()
	
	for mtile in data["tiles"]:
		var newTile = tile_scene.instantiate()
		newTile.position.x = mtile["pos_x"]
		newTile.position.y = mtile["pos_y"]
		newTile.position.z = mtile["pos_z"]
		add_child(newTile)
		
	save_game.close()

func get_tiles() -> void:
	tiles = []
	var tiles_in_scene := get_tree().get_nodes_in_group("Tile")
	for tile in tiles_in_scene:
		tiles.append(tile)

func clear() -> void: 
	get_tiles()
	
	for tile in tiles:
		tile.queue_free()
	
	#TODO destroy characters
