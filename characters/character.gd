extends Node3D
class_name Character

@export var moveSpeed := 0.6
@export var movement := 2
@export var currentTile: Tile


var moveTimer = 0.0
var currentPosition: Vector3
var destination: Vector3
var movableTiles = []

#All tiles are currently 0.5 tall, so the top is 0.25 above center
const tileHeight = Vector3(0.0, 0.25, 0.0)

#TODOs
#	Expand movability to take in movement distance
#	Use the algorithm from movability for pathfinding and move 1 square at time
#	limit moving to a movable tile
#	Have controller start selecting an active character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	moveTimer += delta * moveSpeed
	if(moveTimer < 1):
		global_position = currentPosition.lerp(destination, moveTimer)

func assignTile(tile: Tile) -> void: 
	clear_movable_tiles()
	currentTile = tile
	destination = tile.get_move_position()
	currentPosition = global_position
	moveTimer = 0.0
	highlight_movable_tiles()

func highlight_movable_tiles() -> void: 
	movableTiles = currentTile.get_neighboring_tiles()
	for _tile in movableTiles:
		_tile.is_movable(true)

func clear_movable_tiles() -> void:
	for _tile in movableTiles:
		_tile.is_movable(false)

func populate_movable_tiles(movement: int) -> void:
	var move_tiles_temp
	pass

func get_tile_key(tile: Tile) -> String:
	return "test"
