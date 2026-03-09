extends Node3D

@onready var world_environment: WorldEnvironment = $Node3D/WorldEnvironment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/Camera3D.make_current()
	$Player/Camera3D.environment = world_environment
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
