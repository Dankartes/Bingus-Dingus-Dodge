class_name Player
extends Area2D


signal hit

@export var speed: int = 400

var screen_size: Vector2
var character_size: Vector2

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func start(pos: Vector2) -> void:
	position = pos
	show()
	collision_shape.disabled = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	character_size = collision_shape.shape.get_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		animated_sprite.play()

	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO  + character_size / 2, screen_size - character_size / 2)
	
	if velocity.x || velocity.y  != 0:
		animated_sprite.animation = "walk"
		animated_sprite.flip_h = velocity.x < 0
	else:
		animated_sprite.animation = "idle"
	
	


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	collision_shape.set_deferred("disabled", true);
