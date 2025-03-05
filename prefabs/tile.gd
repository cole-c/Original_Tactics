extends Node3D
class_name Tile

@export var level := 1

@onready var mesh: CollisionShape3D = $RigidBody3D/CollisionShape3D
@onready var rigid: RigidBody3D = $RigidBody3D
@onready var movable_highlight: CSGBox3D = $RigidBody3D/CollisionShape3D/MovableHighlightBox
@onready var hover_highlight: CSGBox3D = $RigidBody3D/CollisionShape3D/HoverHighlightBox


#All tiles are currently 0.5 tall, so the top is 0.25 above center
const tileHeight = Vector3(0.0, 0.25, 0.0)

func get_adjacent_tiles() -> void:
	# TODO
	# Either use raycasts to detect here or 
	# In controller, create a map where key is (tile level, x, y) and add all tiles to that at the start
	# by getting them by group and checking their X,Y. Level can be calculated if there are multiple that
	# share X,Y, then sort by Z and assign levels
	# add can_move_up, can_move_down here for between levels or just "linked tiles" for teleporters, etc
	pass

func get_move_position() -> Vector3:
	return Vector3(global_position) + tileHeight

func isMovable(movable: bool) -> void:
	movable_highlight.visible = movable

func isHovered(hover: bool) -> void:
	hover_highlight.visible = hover
