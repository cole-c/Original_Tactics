extends Camera3D

@export var character: Character

@onready var ray_cast_3d: RayCast3D = $RayCast3D

var hovered_tile: Tile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 100.0
	ray_cast_3d.force_raycast_update()
	if(ray_cast_3d.is_colliding()):
		var collider : RigidBody3D = ray_cast_3d.get_collider()
		if (collider.is_in_group("Tile")):
			var new_hovered_tile = collider.get_parent()
			if(!hovered_tile):
				hovered_tile = new_hovered_tile
			if(new_hovered_tile != hovered_tile):
				hovered_tile.is_hovered(false)
				hovered_tile = new_hovered_tile
			if(hovered_tile.get_movable()):
				hovered_tile.is_hovered(true)
			if(Input.is_action_just_pressed("click_L") && (character.currentTile == null || hovered_tile.get_movable())):
				character.assignTile(hovered_tile)
	else: 
		if(hovered_tile):
			hovered_tile.is_hovered(false)
		hovered_tile = null
