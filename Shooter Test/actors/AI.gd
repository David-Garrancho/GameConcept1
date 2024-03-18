extends Node2D


@onready var player_detection_zone = $PlayerDetection
signal state_changed(new_state)

enum State{
	PATROL,
	ENGAGE
}


var current_state: int = State.PATROL : set = set_state
var actor = null
var player: Player = null
var weapon: Weapon = null


func _process(delta):
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and weapon != null:
				actor.rotation = actor.global_position.direction_to(player.global_position).angle()
				weapon.shoot()
			else:
				print("In the engage state but no weapon/player")
		_:
			print("Error: found a state for enemy that doesn't exist")

func initialize(actor, weapon: Weapon):
	self.actor = actor
	self.weapon = weapon	
	

func set_state(new_state: int):
	if new_state == current_state:
		return
	
	current_state = new_state
	emit_signal("state_changed", current_state)
	

func _on_player_detection_body_entered(body):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body
