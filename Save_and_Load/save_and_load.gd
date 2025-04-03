extends Node

class_name SaveAndLoad

@export var gameController: GameController
@export var fileName: String = "testMap.JSON"

var savePath: String = "res://Save_and_Load/SavedFiles/"
var tiles = []

func Save():
	var saveFile = savePath + fileName
	SaveMap(saveFile)

func SaveMap(saveFile):
	var main_dict = {
		"version": "Alpha",
		"tiles": []
	}
	
	get_tiles()
	
	for tile in tiles:
		var save_dict = {
			"pos_x" : tile.pos.x,
			"pos_y" : tile.pos.y,
			"pos_z" : tile.pos.z
		}
		main_dict["tiles"].append(save_dict)
	
	var save_game = FileAccess.open(saveFile, FileAccess.WRITE)
	
	var json_string = JSON.stringify(main_dict, "\t", false)
	save_game.store_line(json_string)

func get_tiles() -> void:
	var tiles_in_scene := get_tree().get_nodes_in_group("Tile")
	for tile in tiles_in_scene:
		tiles.append(tile)
