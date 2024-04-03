extends Node2D


@onready var patrol_timer = $PatrolTimer

signal state_changed(new_state)

enum State{
	PATROL,
	ENGAGE
}


var current_state: int = -1 : set = set_state
var actor: CharacterBody2D = null
var target: CharacterBody2D = null
var weapon: Weapon = null

#Patrol State
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO
var patrol_location_reached: bool = false
var actor_velocity: Vector2 = Vector2.ZERO
var team: int = -1

func _ready():
	set_state(State.PATROL)

func _physics_process(delta):
	match current_state:
		State.PATROL:
			if not patrol_location_reached:
				actor.velocity = actor_velocity
				actor.move_and_slide()
				actor.rotate_toward(patrol_location)
				if actor.global_position.distance_to(patrol_location) < 5:
					patrol_location_reached = true
					actor_velocity = Vector2.ZERO
					patrol_timer.start()
		State.ENGAGE:
			if target != null and weapon != null:
				actor.rotate_toward(target.global_position)
				var angle_to_target = actor.global_position.direction_to(target.global_position).angle()
				if abs(actor.rotation - angle_to_target) < 0.1 or abs(actor.rotation - angle_to_target) > 6.23:
					weapon.shoot()
			else:
				print("In the engage state but no weapon/target")
		_:
			print("Error: found a state for enemy that doesn't exist")


func initialize(actor: CharacterBody2D, weapon: Weapon, team: int):
	self.actor = actor
	self.weapon = weapon	
	self.team = team
	

func set_state(new_state: int):
	if new_state == current_state:
		return
		
	if new_state == State.PATROL:
		origin = global_position
		patrol_timer.start()
		patrol_location_reached = true
	
	current_state = new_state
	emit_signal("state_changed", current_state)


func _on_patrol_timer_timeout():
	var patrol_range = 50
	var random_x = randf_range(-patrol_range, patrol_range)
	var random_y = randf_range(-patrol_range, patrol_range)
	patrol_location = Vector2(random_x, random_y) + origin
	patrol_location_reached = false
	actor_velocity = actor.velocity_toward(patrol_location)




func _on_DetectionZone_body_entered(body):
	if body.has_method("get_team") and body.get_team() != team:
		set_state(State.ENGAGE)
		target = body


func _on_DetectionZone_body_exited(body):
	if target and body == target:
		set_state(State.PATROL)
		target = null
