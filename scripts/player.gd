extends CharacterBody2D

const SPEED = 135.0
const ACCELERATION = 150.0
const FRICTION = 240.0

const GRAVITY = 2000.0
const FALL_GRAVITY = 3000.0
const FAST_FALL_GRAVITY = 5000.0

const JUMP_VELOCITY = -500.0

const INPUT_BUFFER = 0.125
const JUMP_BUFFER = 0.08

var input_buffer_timer : Timer
var jump_buffer_timer : Timer
var jump_available : bool = true

@onready var sprite_2d := $AnimatedSprite2D

func _ready():
	# Setup input buffer timer
	input_buffer_timer = Timer.new()
	input_buffer_timer.wait_time = INPUT_BUFFER
	input_buffer_timer.one_shot = true
	add_child(input_buffer_timer)

	# Setup coyote timer
	jump_buffer_timer = Timer.new()
	jump_buffer_timer.wait_time = JUMP_BUFFER
	jump_buffer_timer.one_shot = true
	add_child(jump_buffer_timer)

func _physics_process(delta):
	var horizontal_input = Input.get_axis("ui_left","ui_right") 
	var jump_attempted = Input.is_action_just_pressed("ui_select")
	
	# Sprite
	if is_on_floor():
		if horizontal_input:
			sprite_2d.play("run")
		else:
			sprite_2d.play("idle")
	else:
		sprite_2d.play("jump")
	
	if horizontal_input == -1:
		sprite_2d.flip_h = true
	if horizontal_input == 1:
		sprite_2d.flip_h = false
		
	# Handle jumping
	if jump_attempted or input_buffer_timer.time_left > 0:
		if jump_available:
			velocity.y = JUMP_VELOCITY
			jump_available = false
		elif jump_attempted:
			input_buffer_timer.start()
	
	if Input.is_action_just_released("ui_select") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4

	if is_on_floor():
		jump_available = true
		jump_buffer_timer.stop()
	else:
		if jump_available:
			if jump_buffer_timer.is_stopped():
				jump_buffer_timer.start()
		velocity.y += get_the_gravity() * delta
		
		if jump_buffer_timer.timeout:
				jump_available = false

	var floor_damping : float = 1.0 if is_on_floor() else 0.2
	var dash_multiplier : float = 2.0 if Input.is_action_pressed("ui_home") else 1.0

	if horizontal_input:
		velocity.x = move_toward(velocity.x, horizontal_input * SPEED * dash_multiplier, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * dash_multiplier * delta)

	move_and_slide()


func get_the_gravity():
	if Input.is_action_just_pressed("ui_down"):
		return FAST_FALL_GRAVITY
	else:
		return GRAVITY
