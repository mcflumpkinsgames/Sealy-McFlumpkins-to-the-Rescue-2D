extends Node2D

@export var lives = 3
var score = 0
@onready var player = $Player
@onready var hud = $UI/HUD

@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_hit_sound = $PlayerHitSound

var game_over_screen = preload("res://scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_death_zone_area_entered(area):
	area.queue_free()


func _on_player_took_damage():
	player_hit_sound.play()
	lives -= 1
	hud.set_lives(lives)
	
	if (lives <= 0):
		player.die()
		await get_tree().create_timer(1.5).timeout
		show_game_over()
	else:
		print("lives is now " + str(lives))
		

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	enemy_hit_sound.play()
	score += 100;
	hud.set_score_label(score)
	print("woo hoo! " + str(score) + " points!")

func show_game_over():
	var game_over_screen_instance = game_over_screen.instantiate()
	game_over_screen_instance.set_score(score)
	hud.add_child(game_over_screen_instance)
	

func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
