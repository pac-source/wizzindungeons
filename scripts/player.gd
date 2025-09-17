extends CharacterBody2D

const SPEED = 105.0
const ACCELERATION = 120.0
const FRICTION = 420.0
const MAX_SPEED = 125.0
const MIN_DASH_SPEED = 165.0
const MAX_DASH_SPEED = 420.0

const GRAVITY = 2000.0
const FALL_GRAVITY = 3000.0
const FAST_FALL_GRAVITY = 30000.0

const JUMP_VELOCITY = -550.0
const MAX_JUMP_VELOCITY = -590.0

const INPUT_BUFFER = 0.125
const COYOTE_TIME = 0.08 

var input_buffer_timer : Timer
var coyote_timer = 0.0
var jump_available : bool = true
var duck_down = 1

@onready var sprite_2d := $AnimatedSprite2D
@onready var player: CharacterBody2D = $"."

func _ready():
	# Setup input buffer timer
	input_buffer_timer = Timer.new()
	input_buffer_timer.wait_time = INPUT_BUFFER
	input_buffer_timer.one_shot = true
	add_child(input_buffer_timer)

func _physics_process(delta : float):
	var horizontal_input = Input.get_axis("move_left", "move_right") 
	var jump_attempted = Input.is_action_just_pressed("jump")
	
	## SPRITE  ANIMATION
	# basic animation
	if is_on_floor():
		if horizontal_input and !Input.is_action_pressed("dash"):
			sprite_2d.play("walk")
		elif horizontal_input and Input.is_action_pressed("dash"):
			sprite_2d.play("run")
		else:
			sprite_2d.play("idle")
	else:
		sprite_2d.play("jump")
	
	#flip sprite
	if horizontal_input == -1:
		sprite_2d.flip_h = true
	if horizontal_input == 1:
		sprite_2d.flip_h = false
		
	## HANDLE JUMPING
	# buffer jumping
	if jump_attempted or input_buffer_timer.time_left > 0:
		if jump_available:
			if Input.is_action_pressed("dash"):
				velocity.y = MAX_JUMP_VELOCITY
			else:
				velocity.y = JUMP_VELOCITY
			jump_available = false
		elif jump_attempted:
			input_buffer_timer.start()
	
	if input_buffer_timer.timeout:
		jump_available = false
	if is_on_floor():
		jump_available = true
		
	# coyote jump 
		# don't change this indendation
		coyote_timer = COYOTE_TIME
	coyote_timer -= delta
	# print("coyote time: " + str(coyote_timer) + "\ndelta: " + str(delta))
	if coyote_timer <= 0:
		jump_available = false
	else:	
		jump_available = true
	
	# short jump	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4

	## MOVEMENT
	# dashing
	var floor_damping : float = 2.0 if is_on_floor() else 0.2
	var dash_multiplier : float = 1.6 if Input.is_action_pressed("dash") else 1.0
	
	# basic movements
	if horizontal_input:
		velocity.x += horizontal_input * SPEED * dash_multiplier * delta
		var current_velocity = -velocity.x if velocity.x < 0 else velocity.x
		# prevent movement sliding 
		if (horizontal_input > 0 and  velocity.x < 0) or (horizontal_input < 0 and velocity.x > 0) :
			velocity.x = move_toward(velocity.x, horizontal_input, FRICTION * floor_damping * delta)
		
		if current_velocity > MAX_SPEED and !Input.is_action_pressed("dash"):
			velocity.x = MAX_SPEED if velocity.x > 0 else -MAX_SPEED
		elif Input.is_action_pressed("dash"): 
			if current_velocity < MIN_DASH_SPEED:
				velocity.x += horizontal_input * SPEED * dash_multiplier * duck_down * delta
			elif current_velocity > MAX_DASH_SPEED:
				velocity.x -= horizontal_input * SPEED * dash_multiplier * duck_down * delta
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * floor_damping * delta)
	
	## RAYCAST OFFSET
	#### TODO: FIX raycast errors 
	#if player.left_outer.is_colliding() and !player.left_inner.is_colliding() and !player.right_inner.is_colliding() and !player.right_outer.is_colliding():
		#player.golbal_position.x -= 5
	#elif !player.left_outer.is_colliding() and !player.left_inner.is_colliding() and !player.right_inner.is_colliding() and player.right_outer.is_colliding():
		#player.global_position.x += 5
	
	## GRAVITY AND OTHER PHYSICS
	velocity.y += get_the_gravity() * delta	
	move_and_slide()

func enemy_bounce():
	velocity.y = JUMP_VELOCITY / 2
	jump_available = false

func get_the_gravity():
	if Input.is_action_pressed("duck_down"):
		sprite_2d.play("pound")
		duck_down = 0
		return 0
	else:
		duck_down = 1
		return GRAVITY

func return_velocity():
	return velocity.y
