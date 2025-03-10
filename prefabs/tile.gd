extends Node3D
class_name Tile

@export var level := 1

@onready var mesh: CollisionShape3D = $RigidBody3D/CollisionShape3D
@onready var rigid: RigidBody3D = $RigidBody3D
@onready var movable_highlight: CSGBox3D = $RigidBody3D/CollisionShape3D/MovableHighlightBox
@onready var hover_highlight: CSGBox3D = $RigidBody3D/CollisionShape3D/HoverHighlightBox
@onready var ray_cast: RayCast3D = $RayCast


#All tiles are currently 0.5 tall, so the top is 0.25 above center
const tileHeight = Vector3(0.0, 0.25, 0.0)
const levelMaxHeight = Vector3(0.0, 100.0, 0.0)
const horizontalNeighbor = Vector3(1.0, 0.0, 0.0)
const verticalNeighbor = Vector3(0.0, 0.0, 1.0)

var test_highlights = false

func get_adjacent_tiles() -> void:
	# TODO
	# Either use raycasts to detect here or 
	# In controller, create a map where key is (tile level, x, y) and add all tiles to that at the start
	# by getting them by group and checking their X,Y. Level can be calculated if there are multiple that
	# share X,Y, then sort by Z and assign levels
	# add can_move_up, can_move_down here for between levels or just "linked tiles" for teleporters, etc
	pass

func get_neighboring_tiles() -> Array: 
	var neighbors = []
	neighbors.append_array(get_individual_neighbors(horizontalNeighbor))
	#neighbors.append_array(get_individual_neighbors(-horizontalNeighbor))
	#neighbors.append_array(get_individual_neighbors(verticalNeighbor))
	#neighbors.append_array(get_individual_neighbors(-verticalNeighbor))
	return neighbors

func get_individual_neighbors(offset: Vector3) -> Array:
	var neighbors = []
	ray_cast.clear_exceptions()
	
	ray_cast.debug_shape_custom_color = Color.RED
	ray_cast.debug_shape_thickness = 20
	
	ray_cast.position = levelMaxHeight + offset
	ray_cast.target_position = Vector3(0.0, -110.0, 0.0)
	ray_cast.force_raycast_update()
	
	print("Pos: x:" + str(ray_cast.position.x) + "  y:" + str(ray_cast.position.y) + "  z:" + str(ray_cast.position.z))
	print("Tar: x:" + str(ray_cast.target_position.x) + "  y:" + str(ray_cast.target_position.y) + "  z:" + str(ray_cast.target_position.z))

	var collision = ray_cast.get_collider()
	while(collision != null):
		if (collision.is_in_group("Tile")):
			print("Found a tile!")
			#TODO: multi-level tile handling
			neighbors.append(collision.get_parent())
		ray_cast.add_exception(collision)
		ray_cast.force_raycast_update()
		collision = ray_cast.get_collider()
	return neighbors

func get_move_position() -> Vector3:
	return Vector3(global_position) + tileHeight

func is_movable(movable: bool) -> void:
	movable_highlight.visible = movable

func is_hovered(hover: bool) -> void:
	hover_highlight.visible = hover

func _process(_delta: float) -> void:
	pass
