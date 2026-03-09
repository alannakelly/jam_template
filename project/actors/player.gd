extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var look_sensitivity = 0.2
@onready var ray_cast_3d: RayCast3D = $Camera3D/Weapon/RayCast3D
@onready var gun_fire_rate: Timer = $Camera3D/Weapon/GunFireRate
@onready var animation_player: AnimationPlayer = $Camera3D/Weapon/AnimationPlayer


var look = Vector2.ZERO

var is_gun_ready = true
var is_shooting = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look.x -= event.relative.y * look_sensitivity
		look.y -= event.relative.x * look_sensitivity
		look.x = clampf(look.x,-90,90)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_shooting = true
			else:
				is_shooting = false
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("strafe_left", "strafe_right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	rotation_degrees.y = look.y
	$Camera3D.rotation_degrees.x = look.x

	if is_shooting and is_gun_ready:
		print("Shooting")
		gun_fire_rate.start()
		is_gun_ready = false
		if ray_cast_3d.is_colliding():
			print("Hitting something")
		animation_player.play("Shooting")

func _on_gun_fire_rate_timeout() -> void:
	is_gun_ready = true
