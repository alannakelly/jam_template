extends Node3D

@export var weapon_name: String = "Unknown"
@export var ammo: int = 0;
@export var ammo_per_clip = 12;
@export var animation_player: AnimationPlayer
signal no_ammo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func fire() -> void:
	if ammo > 0:
		if ammo > 1:
			animation_player.play('Fire')
		else:
			animation_player.play('FireLastOne')
		ammo -= 1
	else:
		emit_signal("no_ammo")

func reload() -> void:
	animation_player.play('Reload')
	ammo = ammo_per_clip
	pass
