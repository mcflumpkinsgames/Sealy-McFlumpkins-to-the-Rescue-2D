extends Node2D

@export var lives = 3
var score = 0
@onready var player = $Player
@onready var hud = $UI/HUD

func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_death_zone_area_entered(area):
	area.die()


func _on_player_took_damage():
	lives -= 1
	hud.set_lives(lives)
	
	if (lives <= 0):
		print("I'm ded")
		player.die()
	else:
		print("lives is now " + str(lives))
		

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100;
	hud.set_score_label(score)
	print("woo hoo! " + str(score) + " points!")