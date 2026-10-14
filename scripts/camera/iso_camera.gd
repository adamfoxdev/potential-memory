extends Node3D
## Diablo-style fixed-angle camera rig that follows a target.

@export var target_path: NodePath
@export var follow_speed := 8.0

@onready var target: Node3D = get_node_or_null(target_path)

func _process(delta: float) -> void:
	if target:
		global_position = global_position.lerp(target.global_position, clampf(follow_speed * delta, 0.0, 1.0))
