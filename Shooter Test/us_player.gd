extends CharacterBody2D


@export var speed: int = 200
@export var run_speed: int = 300
@export var Bullet :PackedScene 


@onready var end_of_gun = $EndOfGun

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
	
func _unhandled_input(event):
	if event.is_action_released("shoot"):
		shoot()
		
		

func shoot():
	var bullet_instance = Bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance.global_position = end_of_gun.global_position
	var target = get_global_mouse_position()
	var direction_to_mouse = bullet_instance.global_position.direction_to(target).normalized()
	bullet_instance.set_direction(direction_to_mouse)
	$Shooting.play()
	

