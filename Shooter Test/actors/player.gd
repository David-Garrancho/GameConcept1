extends CharacterBody2D
class_name Player

@export var speed: int = 100
@export var run_speed: int = 150

@onready var weapon = $Weapon
@onready var health_stat = $Health

signal player_fired_bullet(bullet, position, direction)

func _ready(): 
	weapon.connect("weapon_fired", shoot)


func _physics_process(delta: float) -> void: 
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
		weapon.shoot()
		
		

func shoot(bullet_instance, location: Vector2, direction: Vector2):
	emit_signal("player_fired_bullet", bullet_instance, location, direction)
		

func handle_hit():
	health_stat.health -= 20
	print("Player hit! ", health_stat.health)
