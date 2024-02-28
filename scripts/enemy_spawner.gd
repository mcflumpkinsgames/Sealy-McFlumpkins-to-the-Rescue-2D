extends Node2D

@onready var timer = $Timer
@onready var path_enemy_timer = $PathEnemyTimer
@onready var spawn_positions = $SpawnPositions

signal enemy_spawned(enemy_instance)

var enemy = preload("res://scenes/enemy.tscn")

func _ready():
	timer.connect("timeout", _on_timeout)
	path_enemy_timer.connect("timeout", _on_path_enemy_timeout)
	
func _on_timeout():
	spawn_enemy()
	
func _on_path_enemy_timeout():
	pass
	
func spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var spawn_position = spawn_positions_array.pick_random()
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_position.global_position
	emit_signal("enemy_spawned", enemy_instance)
