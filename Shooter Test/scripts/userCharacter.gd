extends CharacterBody2D

func handelInput():
	var moveDirection = Input.get_vector("ui_right", "ui_left", "ui_up", "ui_down")
	velocity = moveDirection
	
func _physics_process(delta):
	handle
