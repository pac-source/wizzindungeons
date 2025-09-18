extends CharacterBody2D

const SPEED: float = 27
const ACCLERATION: float = 5.5
const GRAVITY: float = 200.0

var direction: int = 1
var y_differnce_player_enemy : float = 0.0
var is_alive = true

@onready var raycast_left: RayCast2D = $raycast_left
@onready var raycast_right: RayCast2D = $raycast_right
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var collision_for_enemy: CollisionShape2D = $collision_for_enemy
@onready var animation: AnimationPlayer = $animation


func _physics_process(delta : float) -> void:
	velocity.x = move_toward(velocity.x, SPEED * delta, ACCLERATION * delta)
	velocity.y = GRAVITY * delta
	
func _process(delta : float) -> void:
	if !(visible_on_screen_notifier_2d.is_on_screen()):
		return
	if not is_on_floor():
		position.y += velocity.y
		animated_sprite_2d.play("fall")
	
	elif is_on_floor() and is_alive:
		animated_sprite_2d.play("walk")
		position.x += velocity.x * direction
		if  raycast_right.is_colliding():
			direction = -1
			animated_sprite_2d.flip_h = true
		
		elif raycast_left.is_colliding():
			direction = 1
			animated_sprite_2d.flip_h = false
	
	move_and_slide()



func _on_hitbox_body_entered(body: Node2D) -> void:
	if(body.name == "player"):
		y_differnce_player_enemy = position.y - body.position.y
		print("ply pos: " + str(body.position.y) + " enem pos: " + str(position.y))
		if (body.position.y < position.y):
			player_variables.level_restart()
			print("you die")
		else:
			body.enemy_bounce()
			is_alive = false
			animation.play("die")
			#print("he dies")
