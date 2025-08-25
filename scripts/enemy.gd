extends CharacterBody2D

const SPEED: float = 27
const ACCLERATION: float = 5.5
const GRAVITY: float = 2000.0

func _physics_process(delta : float) -> void:
	velocity.x = move_toward(velocity.x, SPEED * delta, ACCLERATION * delta)
	velocity.y = GRAVITY * delta
	
func _process(delta : float) -> void:	
	position.x += velocity.x
	#if (unknowncondition):
	#	position.y += velocity.y
