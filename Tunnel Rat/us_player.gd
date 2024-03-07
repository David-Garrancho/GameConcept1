extends CharacterBody2D


@export var speed: int = 200
@export var run_speed: int = 500


func _ready() -> void:
	pass


func _process(delta: float) -> void: 
	var movement_direction := Vector2.ZERO
	if Input.is_action_pressed("move_up"): #Assists in direction of movement
		movement_direction.y = -1
	if Input.is_action_pressed("move_down"):
		movement_direction.y = 1
	if Input.is_action_pressed("move_left"):
		movement_direction.x = -1
	if Input.is_action_pressed("move_right"):
		movement_direction.x = 1
		
	velocity = movement_direction * speed
	
	if Input.is_action_pressed("run"): #Handles running input
		velocity = movement_direction * run_speed
	
	move_and_slide() #Allows character on screen to move
	
	look_at(get_global_mouse_position()) #Makes character aim in direction of mouse
	
func _unhandled_input(event: InputEvent) -> void:
	pass
	
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

#	move_and_slide()
