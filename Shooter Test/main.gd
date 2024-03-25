extends Node2D

@onready var bullet_manager = $BulletManager
@onready var player: Player = $Player


func _ready():
	randomize()
	GlobalSignals.connect("bullet_fired", Callable(bullet_manager, "handle_bullet_spawned"))

