extends Area2D

@export var speed = 200
@onready var visible_notifier = $VisibleNotifier

func _ready():
	visible_notifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta):
	global_position.x -= speed * delta
	
func _on_screen_exited():
	queue_free()
	
func die():
	print("Ow, wtf, man?")
	queue_free()