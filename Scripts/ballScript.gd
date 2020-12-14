extends Node2D

var dirY = 1
var dirX = 1
var speed = 112 
var rotationvalue = 12

export (NodePath) var controlPath 
onready var control = get_node(controlPath)

func _physics_process(delta):
	
	if dirY == 1:
		position.y += speed * delta
		
	elif dirY == -1:
		position.y -= speed * delta
		
	if dirX == 1:
		position.x += speed * delta
		
	elif dirX == -1:
		position.x -= speed * delta
		
	scale.x = 0.0012 * position.y
	scale.y = 0.0012 * position.y
	
	#print ("escala "  + str(scale.x))
	$Sprite.rotation += rotationvalue  * delta
	

func _on_Area2D_area_entered(area):
	if area.is_in_group('topeslaterales'):
		print("choque con lateral")
		dirX *= -1
		
	if area.is_in_group('topesvida'):
		print("quitar vida a alguien")
		if area.corresponde == "Player":
			print ("al player")
			area.quitarvida(Global.golpes)
			Global.golpes = 0
		dirY *= -1
		speed += 25
		
	if area.is_in_group('espada'):
		Global.golpes += 1
		print("toque espada")
		
		if control != null:
			control.update_golpes()
		
		dirY *= -1
		speed += 50
