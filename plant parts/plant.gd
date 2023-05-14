extends Node2D

signal out_of_energy
signal regained_energy

var energy = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# first stage of growth!
func _on_seed_germinated():
	var seed = get_node("Seed")
	# grab the position of the seed so the pland knows where to grow
	var position = seed.position.round()
	seed.queue_free()
	print("My hull has cracked.")
	
	# load the stem scene, and put it in place of the seed
	var Stem = preload("res://plant parts/stem.tscn").instantiate()
	Stem.position = position
	Stem.grow_stem.connect(_on_stem_grow)
	add_child(Stem)
	print("My body wakes, new and green.")
	print("I'm a big kid now...\n")
	
	# load the root scene, and put it under the stem
	var Root = preload("res://plant parts/root.tscn").instantiate()
	Root.position = position + Vector2(0,1)
	Root.grow_root.connect(_on_root_grow)
	add_child(Root)


func _on_stem_grow(growth_position, emitter):
#	print(growth_position)
#	print(emitter.position)
	
	var Stem = preload("res://plant parts/stem.tscn").instantiate()
	Stem.position = emitter.position + growth_position
	Stem.grow_stem.connect(_on_stem_grow)
	Stem.grow_leaf.connect(_on_leaf_grow)
	add_child(Stem)
#	print("I'm a bigger kid now...\n")
	
	change_energy(-1)

func _on_root_grow(growth_position, emitter):
	var Root = preload("res://plant parts/root.tscn").instantiate()
	Root.position = emitter.position + growth_position
	Root.grow_root.connect(_on_root_grow)
	add_child(Root)
	
	change_energy(2)

func _on_leaf_grow(growth_position, emitter):
	var Leaf = preload("res://plant parts/leaf.tscn").instantiate()
	Leaf.position = emitter.position + growth_position
	Leaf.photosynthesize.connect(_on_photosynthesize)
	add_child(Leaf)

func _on_photosynthesize():
	change_energy(1)

func change_energy(amount):
	var old_energy = energy
	energy += amount
	if energy <= 0:
		out_of_energy.emit()
		print("MORTAL, I HUNGER.")
	elif old_energy <= 0 and energy > 0:
		regained_energy.emit()
