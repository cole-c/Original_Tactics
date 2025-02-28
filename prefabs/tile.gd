extends Node3D
class_name Tile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_tile_size() -> Vector3:
	for child in get_children():
		if child is RigidBody3D:
			return child.get_size()
	print("Tile get_position messed up")
	return Vector3()
