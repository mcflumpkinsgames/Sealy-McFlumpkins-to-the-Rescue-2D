extends Control
@onready var score = $Score
@onready var score_text = "Score: "
@onready var lives_left = $LivesLeft


func set_score_label(new_score):
	var score_string = str(new_score)
	score.text = score_text + score_string
	
func set_lives(amount):
	lives_left.text = str(amount)
