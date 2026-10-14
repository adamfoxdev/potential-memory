extends CharacterBody3D
## Click-to-move player using NavigationAgent3D.

@export var speed := 6.0
@export var turn_speed := 12.0

@onready var agent: NavigationAgent3D = $NavigationAgent3D

func move_to(point: Vector3) -> void:
	agent.target_position = point

func _physics_process(delta: float) -> void:
	if agent.is_navigation_finished():
		velocity = Vector3.ZERO
		return
	var next := agent.get_next_path_position()
	var dir := next - global_position
	dir.y = 0.0
	if dir.length() > 0.05:
		dir = dir.normalized()
		velocity = dir * speed
		var target_yaw := atan2(-dir.x, -dir.z)
		rotation.y = lerp_angle(rotation.y, target_yaw, clampf(turn_speed * delta, 0.0, 1.0))
	move_and_slide()
