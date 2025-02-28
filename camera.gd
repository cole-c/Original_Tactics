extends Camera3D

@export var character: Character

@onready var ray_cast_3d: RayCast3D = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 100.0
	ray_cast_3d.force_raycast_update()
	if(ray_cast_3d.is_colliding()):
		var collider : RigidBody3D = ray_cast_3d.get_collider()
		print("colliding " + collider.to_string())
		if (collider.is_in_group("Tile")):
			#highlight as moveable
			print("tile found")
			if(Input.is_action_pressed("click_L")):
				print("clicked **************************************")
				character.assignTile(collider.get_parent())
