extends Area2D
class_name Bullet

@export var speed: int = 30

var direction := Vector2.ZERO

@onready var kill_timer = $KillTimer


func _ready():
	kill_timer.start()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity

func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()

func _on_kill_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit()
		queue_free()
