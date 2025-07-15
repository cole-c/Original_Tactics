extends Node3D
class_name Character

@export var moveSpeed := 0.6
@export var movement := 2
@export var currentTile: Tile


var movableTiles = []
var pathfinder := AStar3D.new()
var defaultWeight = 1.0 #All tiles are 1 so our map has no differing weights
var is_moving = false
var path: PackedVector3Array

#TODOs
#	limit moving to a movable tile
#	Have controller start selecting an active character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	pass

func assignTile(tile: Tile) -> void: 
	if(currentTile == null):
		global_position = tile.get_move_position()
	else:
		await move_along_map(tile.a_star_id)
	clear_movable_tiles()
	currentTile = tile
	highlight_movable_tiles()

func move_along_map(_dest: int) -> void:
	path = pathfinder.get_point_path(currentTile.a_star_id, _dest)
	is_moving = true
	for i in range(1, path.size()):
		var tween = create_tween()
		tween.tween_property(self, "position", path[i], moveSpeed)
		await tween.finished

func highlight_movable_tiles() -> void: 
	if(currentTile):
		movableTiles = populate_movable_tiles()
		for _tile in movableTiles:
			_tile.is_movable(true)

func clear_movable_tiles() -> void:
	for _tile in movableTiles:
		_tile.is_movable(false)

func populate_movable_tiles() -> Array:
	pathfinder.clear()
	var visited_queue = [currentTile]
	var head = 0
	var movement_left = movement
	while(movement_left > 0):
		var current_queue_size = visited_queue.size()
		for i in range(head, current_queue_size):
			var visited_tile = visited_queue[i]
			if !visited_tile.a_star_id:
				visited_tile.a_star_id = pathfinder.get_available_point_id()
				pathfinder.add_point(visited_tile.a_star_id, visited_tile.get_move_position(), defaultWeight)
			var neighbors = visited_queue[i].get_neighboring_tiles()
			for n_tile in neighbors:
				if !n_tile.a_star_id:
					n_tile.a_star_id = pathfinder.get_available_point_id()
					pathfinder.add_point(n_tile.a_star_id, n_tile.get_move_position(), defaultWeight)
					visited_queue.append(n_tile)
				pathfinder.connect_points(visited_tile.a_star_id, n_tile.a_star_id)
		head = current_queue_size
		movement_left -= 1;
	return visited_queue

func get_tile_key(tile: Tile) -> String:
	return str(tile.position.x) + "," + str(tile.position.y) + "," + str(tile.position.z)
