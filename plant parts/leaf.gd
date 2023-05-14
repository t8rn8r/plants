extends StaticBody2D

# signals the parent plant to grow with a position relative to self
signal photosynthesize

# probability of growing when the timer times out
var photo_prob = 0.1

@onready var _animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	# if there are still open positions for growth
	if randf() < photo_prob:
		photosynthesize.emit()
		_animation_player.play("photosynthesis")
