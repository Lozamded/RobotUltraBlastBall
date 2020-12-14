extends Node2D

var Enemy1_path = preload("res://Objects/Enemys/Enemy1.tscn")
export (NodePath) var control_path = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_random():
	var Enemy1 = Enemy1_path.instance()
	get_parent().add_child(Enemy1)
	
	Enemy1.numero = randi() % 30 + 1
	Enemy1.controlpath = control_path
	Enemy1.getControl()
	
	
	var signo = randi() % 8 + 1
	
	var zigzag = randi() % 12 + 1
	
	if zigzag > 8:
		Enemy1.zigzageo = true
		Enemy1.zigzageo_dir = "izq"
		if zigzag > 10:
			Enemy1.zigzageo_dir = "der"
	
	if signo < 4:
		Enemy1.numero *= -1
		
	Enemy1.update_num()
	
	var pos = randi() % 4 + 1
	
	#print ("en la posición " + str(pos))
	"""
	match pos:
		1:
			Enemy1.position  = $creator1.global_position
			
		2:
			Enemy1.position  = $creator2.global_position
			
		3: 
			Enemy1.position  = $creator3.global_position
			
		4: 
			Enemy1.position  = $creator4.global_position
	"""
	#aparece de forma random
	Enemy1.position = Vector2(rand_range($creator1.global_position.x, $creator4.global_position.x), $creator1.global_position.y)
	
func create_(num):
	var Enemy1 = Enemy1_path.instance()
	get_parent().add_child(Enemy1)

	match num:
		1:
			Enemy1.position  = $creator1.global_position
			
		2:
			Enemy1.position  = $creator2.global_position
			
		3: 
			Enemy1.position  = $creator3.global_position
			
		4: 
			Enemy1.position  = $creator4.global_position


func _on_Timer_timeout():
	#print("Crear araña... ")
	create_random()
	$Timer.wait_time = 6
	$Timer.start()
