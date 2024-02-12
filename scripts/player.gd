extends CharacterBody2D

signal took_damage

var speed = 300
var bubbles = preload("res://scenes/bubbles.tscn")
@export var bubbles_offset = 75
@onready var bubbles_container = $BubblesContainer

func _physics_process(delta):
	velocity = Vector2(0, 0)
	if (Input.is_action_pressed("move_right")):
		velocity.x = speed
	if (Input.is_action_pressed("move_left")):
		velocity.x = -speed
	if (Input.is_action_pressed("move_up")):
		velocity.y = -speed
	if (Input.is_action_pressed("move_down")):
		velocity.y = speed
	
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	
	global_position = global_position.clamp(Vector2(0,0), screen_size)

func _process(delta):
	if (Input.is_action_just_pressed("shoot")):
		shoot()
		

func shoot():
	var bubbles_instance = bubbles.instantiate()
	bubbles_container.add_child(bubbles_instance)
	bubbles_instance.global_position = global_position
	bubbles_instance.global_position.x += bubbles_offset
	
func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
