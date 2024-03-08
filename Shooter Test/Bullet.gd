extends Area2D

@export var speed: int = 50

var direction := Vector2.ZERO


func set_direction(direction: Vector2):
	self.direction = direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity
