extends KinematicBody2D


var move = 1
var move_x = 0

var rotationvalue = 4.12

func _physics_process(delta):
	move_x = ( int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) ) * 12000 *delta
	var dir = 1
	
	if Input.is_action_pressed("ui_right"):
		dir = 1
		
	if Input.is_action_pressed("ui_left"):
		dir = -1
		
		
	if Input.is_action_pressed("sword_left"):
		if $espada.rotation > -1: 
			$espada.rotation -= rotationvalue  * delta
		
	if Input.is_action_pressed("sword_right"):
		if $espada.rotation < 1: 
			$espada.rotation  += rotationvalue  * delta
			
	
	#print ("rot: " + str($espada.rotation))
		
	move_and_slide(Vector2(move_x,1), Vector2(0,-1))

