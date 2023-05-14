extends RigidBody2D

# sends this signal when the seed is ready to grow
signal germinated

# probability that a seed will germinate when the timer triggers
var germination_prob = 0.5
# name of the ground node
var groundName = "Ground"
# whether the seed is on the ground; used as a condition for germination
var grounded = false


func _init():
	print("I'm a little seed,\nsoon to sprout!\nI'll bee a big plant,\ntall and stout!\n")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# do this based on the germination clock
func _on_timer_timeout():
	if grounded:
		var prob = randf()
		if prob < germination_prob:
			print("Oooh! Time to grow up!")
			germinated.emit()


# set whetehr the seed is grounded
func _on_body_entered(body):
	if body.name == "Ground":
		grounded = true
		print("I'm on the ground, on the ground, on the ground, on the groud, on the ground, on the ground, on the ground, on the ground... ON THE GROUND!!!\n")

# set whether the seed is grounded 
func _on_body_exited(body):
	if body.name == "Ground":
		grounded = false
		print("Wheeeeeeeee!!!!\n")
