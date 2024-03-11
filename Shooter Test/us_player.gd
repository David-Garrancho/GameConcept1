extends CharacterBody2D


@export var speed: int = 200
@export var run_speed: int = 300
@export var Bullet :PackedScene 


@onready var end_of_gun = $EndOfGun
@onready var gun_direction = $GunDirection

signal player_fired_bullet(bullet, position, direction)

func _ready() -> void: 
	pass


func _process(delta: float) -> void: 
	var movement_direction := Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		movement_direction.y = -1
	if Input.is_action_pressed("move_down"):
		movement_direction.y = 1
	if Input.is_action_pressed("move_left"):
		movement_direction.x = -1
	if Input.is_action_pressed("move_right"):
		movement_direction.x = 1
		
	velocity = movement_direction * speed
	
	if Input.is_action_pressed("run"):
		velocity = movement_direction * run_speed
	
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
func _unhandled_input(event):
	if event.is_action_released("shoot"):
		shoot()
		
		

func shoot():
	var bullet_instance = Bullet.instantiate()
	#var target = get_global_mouse_position()
	#var direction_to_mouse = end_of_gun.global_position.direction_to(target).normalized()
	var direction = gun_direction.global_position - end_of_gun.global_position
	emit_signal("player_fired_bullet", bullet_instance, end_of_gun.global_position, direction)
	$ShootingSound.play()

