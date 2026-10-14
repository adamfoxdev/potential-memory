extends Node
## Raycasts from the mouse to the ground and tells the player where to go.

@export var player: Node
@export var camera: Camera3D

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("click_move"):
		return
	var mouse := get_viewport().get_mouse_position()
	var from := camera.project_ray_origin(mouse)
	var to := from + camera.project_ray_normal(mouse) * 200.0
	var query := PhysicsRayQueryParameters3D.create(from, to, 1) # layer 1 = ground
	var hit := camera.get_world_3d().direct_space_state.intersect_ray(query)
	if hit:
		player.move_to(hit.position)
