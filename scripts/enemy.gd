extends RigidBody2D

var speed: float = 10
@onready var enemy: RigidBody2D = $"."

func _process(delta : float) -> void:
	enemy.position.x += speed * delta
