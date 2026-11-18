class_name Player
extends CharacterBody2D

#Allows ninjas to change the movement parameters
@export var speed: float = 300.0
@export var jump_velocity: float = -1000.0
@export var gravity_force: Vector2 = Vector2(0, 3000.0)

#Runs every physics frame
func _physics_process(delta: float) -> void:
	#If we are in the air, apply gravity
	if not is_on_floor():
		velocity += gravity_force * delta

	#If jump button pressed and we are on the ground
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	#The inputs along the X-Axis return a float from -1.0 to 1.0
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		#Move in the current direction multiplied by the movement speed
		velocity.x = direction * speed
	else:
		#Otherwise move the velocity to 0
		velocity.x = move_toward(velocity.x, 0, speed)
	
	#Moves the CharacterBody based on the velocity
	move_and_slide()
