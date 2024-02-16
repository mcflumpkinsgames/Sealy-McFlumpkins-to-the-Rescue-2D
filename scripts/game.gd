extends Node2D

@export var lives = 3
var score = 0
@onready var player = $Player
@onready var hud = $UI/HUD

var game_over_screen = preload("res://scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_death_zone_area_entered(area):
	area.die()


func _on_player_took_damage():
	lives -= 1
	hud.set_lives(lives)
	
	if (lives <= 0):
		player.die()
		show_game_over()
	else:
		print("lives is now " + str(lives))
		

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100;
	hud.set_score_label(score)
	print("woo hoo! " + str(score) + " points!")

func show_game_over():
	var game_over_screen_instance = game_over_screen.instantiate()
	game_over_screen_instance.set_score(score)
	hud.add_child(game_over_screen_instance)
