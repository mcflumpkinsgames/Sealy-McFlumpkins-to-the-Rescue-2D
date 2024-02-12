extends Node2D

@onready var timer = $Timer
@onready var spawn_positions = $SpawnPositions

signal enemy_spawned(enemy_instance)

var enemy = preload("res://scenes/enemy.tscn")

func _ready():
	timer.connect("timeout", _on_timeout)
	
func _on_timeout():
	spawn_enemy()
	
func spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var spawn_position = spawn_positions_array.pick_random()
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_position.global_position
	emit_signal("enemy_spawned", enemy_instance)
