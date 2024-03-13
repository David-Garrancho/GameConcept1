extends CharacterBody2D


@export var speed: int = 200
@export var run_speed: int = 300
@export var Bullet :PackedScene 


var health: int = 100


@onready var end_of_gun = $EndOfGun
@onready var gun_direction = $GunDirection
@onready var attack_cooldown = $AttackCooldown
@onready var animation_player = $AnimationPlayer

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
	if attack_cooldown.is_stopped():
		var bullet_instance = Bullet.instantiate()
		var direction = gun_direction.global_position - end_of_gun.global_position
		emit_signal("player_fired_bullet", bullet_instance, end_of_gun.global_position, direction)
		$ShootingSound.play()
		attack_cooldown.start()
		animation_player.play("muzzle_flash")
		

func handle_hit():
	health -= 20
	print("Player hit! ", health)
