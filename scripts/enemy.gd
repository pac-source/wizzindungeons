extends CharacterBody2D

const SPEED: float = 27
const ACCLERATION: float = 5.5
const GRAVITY: float = 200.0

var direction = 1

@onready var raycast_left: RayCast2D = $raycast_left
@onready var raycast_right: RayCast2D = $raycast_right
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var spawn_hit: Area2D = $spawn_hit
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var collision_for_enemy: CollisionShape2D = $collision_for_enemy

func _physics_process(delta : float) -> void:
	velocity.x = move_toward(velocity.x, SPEED * delta, ACCLERATION * delta)
	velocity.y = GRAVITY * delta
	
func _process(delta : float) -> void:
	if !(visible_on_screen_notifier_2d.is_on_screen()):
		return
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


func _on_enemy_death_zone_area_entered(area: Area2D) -> void:
	collision_for_enemy.queue_free()
	animated_sprite_2d.play("dead")
	
