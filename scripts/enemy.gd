extends CharacterBody2D

const SPEED: float = 27
const ACCLERATION: float = 5.5
const GRAVITY: float = 200.0

var direction = 1

@onready var raycast_left: RayCast2D = $raycast_left
@onready var raycast_right: RayCast2D = $raycast_right
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var spawn_hit: Area2D = $spawn_hit

func _physics_process(delta : float) -> void:
	velocity.x = move_toward(velocity.x, SPEED * delta, ACCLERATION * delta)
	velocity.y = GRAVITY * delta
	
func _process(delta : float) -> void:
	if not is_on_floor():
		position.y += velocity.y
		animated_sprite_2d.play("fall")
	
	elif is_on_floor():
		animated_sprite_2d.play("walk")
		position.x += velocity.x * direction
		if  raycast_right.is_colliding():
			direction = -1
			animated_sprite_2d.flip_h = true
		
		elif raycast_left.is_colliding():
			direction = 1
			animated_sprite_2d.flip_h = false
	
	move_and_slide()
