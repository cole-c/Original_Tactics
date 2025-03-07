extends Node3D
class_name Character

@export var moveSpeed := 0.6
@export var movement := 2
@export var currentTile: Tile


var moveTimer = 0.0
var currentPosition: Vector3
var destination: Vector3

#All tiles are currently 0.5 tall, so the top is 0.25 above center
const tileHeight = Vector3(0.0, 0.25, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	moveTimer += delta * moveSpeed
	if(moveTimer < 1):
		global_position = currentPosition.lerp(destination, moveTimer)

func assignTile(tile: Tile) -> void: 
	currentTile = tile
	destination = tile.get_move_position()
	currentPosition = global_position
	moveTimer = 0.0
	highlight_movable_tiles()

func highlight_movable_tiles() -> void: 
	currentTile.get_neighboring_tiles()
