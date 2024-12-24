class_name Mob
extends RigidBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mob_types: Array = animated_sprite.sprite_frames.get_animation_names()
	animated_sprite.play(mob_types[randi() % mob_types.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
