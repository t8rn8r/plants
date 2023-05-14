extends StaticBody2D

# signals the parent plant to grow with a position relative to self
signal grow_root(growth_position: Vector2, emitter: Node)

# probability of growing when the timer times out
var growth_prob = 0.05
# probability of growing a branch
var branch_prob = 0.02
# array of available growing positions
var growth_positions = [Vector2(-1,1),Vector2(1,1)]

var stop_growing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().out_of_energy.connect(_on_parent_out_of_energy)
	get_parent().regained_energy.connect(_on_parent_regained_energy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	# if there are still open positions for growth
	if len(growth_positions) > 0:
		var prob = randf()
		
		if prob < growth_prob:
			# choose one position for growth
			var growth_position = randi() % len(growth_positions)
			# print("Growing at ", growth_positions[growth_position])
			grow_root.emit(growth_positions[growth_position], self)
			# remove that position from available positions
			growth_positions.remove_at(growth_position)
			
			if prob < branch_prob and len(growth_positions) > 0:
				# choose one position for growth
				growth_position = randi() % len(growth_positions)
				# print("Growing at ", growth_positions[growth_position])
				grow_root.emit(growth_positions[growth_position], self)
				# remove that position from available positions
				growth_positions.remove_at(growth_position)
			
			find_child("Timer").stop()
			stop_growing = true

func _on_parent_out_of_energy():
	if not stop_growing:
		find_child("Timer").start()

func _on_parent_regained_energy():
	find_child("Timer").stop()
