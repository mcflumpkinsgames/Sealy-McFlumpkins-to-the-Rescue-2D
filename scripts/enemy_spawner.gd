extends Node2D

@onready var timer = $Timer
@onready var path_enemy_timer = $PathEnemyTimer
@onready var spawn_positions = $SpawnPositions

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

var enemy = preload("res://scenes/enemy.tscn")
var path_enemy = preload("res://scenes/path_enemy.tscn")

func _ready():
	timer.connect("timeout", _on_timeout)
	path_enemy_timer.connect("timeout", _on_path_enemy_timeout)
	
func _on_timeout():
	spawn_enemy()
	
func _on_path_enemy_timeout():
	spawn_path_enemy()
	
func spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var spawn_position = spawn_positions_array.pick_random()
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_position.global_position
	emit_signal("enemy_spawned", enemy_instance)
	
func spawn_path_enemy():
	var path_enemy_instance = path_enemy.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)
