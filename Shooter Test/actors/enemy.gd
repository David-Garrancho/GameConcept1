extends CharacterBody2D

@onready var health_stat = $Health
@onready var ai = $AI
@onready var weapon = $Weapon

@export var speed: int = 100

func _ready():
	ai.initialize(self, weapon)
	
func rotate_toward(location: Vector2):
	rotation = lerp_angle(rotation, global_position.direction_to(location).angle(), 0.1)

func velocity_toward(location: Vector2):
	return global_position.direction_to(location) * speed

func handle_hit():
	health_stat.health -= 20
	if health_stat.health <= 0:
		queue_free()
		print("Enemy Down")

