extends Node2D


export var numero = 2
var speed = 50
var speed_subida_golpe = 75
var atacando = false
var irreductible = false


export var zigzageo = false
var speed_zig = 65
var zigzageo_dir = "nulo"

var estado = "bajando"

var controlpath
var control

var explosion = preload("res://Particles/Explosion.tscn")
var mininum = preload("res://Objects/Enemys/num_mini.tscn")
var enemyabsorb = preload("res://Objects/Enemys/Enemy1_Absorb.tscn")

# warning-ignore:unused_signal
signal enemyVictory


# Called when the node enters the scene tree for the first time.
func _ready():
	#print ("my name is " + str(name))
	update_num()
	$Area2D.add_to_group("enemys")
	
func getControl():
	if controlpath != "":
		control = get_node_or_null(controlpath)
	
func _physics_process(delta):
	match estado:
		"bajando":
			position.y += speed * delta
			
			if zigzageo:
				match zigzageo_dir:
					"der":
						position.x += speed_zig * delta
					"izq":
						position.x -= speed_zig * delta
				 
			
		"subiendo":
			position.y -= speed_subida_golpe * delta
			

func update_num():
	
	if numero > 99:
		numero = 99
		
	if numero < -99:
		numero = -99
		
	if numero < 10 and numero > -10:
		$numero.add_color_override("font_color", Color(1,1,1,1))
	
	if numero > 10 or numero < -10:
		$numero.add_color_override("font_color", Color(1,0.3,0.3,1))
	
	if numero > 20 or numero < -20:
		$numero.add_color_override("font_color", Color(1,0,0,1))
		
	if numero > 30 or numero <-30:
		$numero.add_color_override("font_color", Color(1,0,0,1))
	
	
	if numero == 0:
		destroy()
	$numero.text = str(numero)	
	

	
func update_num_specific(num):
	$numero.text = str(num)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func restar(num):
	numero -= num
	update_num()
	
func sumar(num):
	numero += num
	update_num()
	

func destroy():
	var explosion1 = explosion.instance()
	get_parent().add_child(explosion1)
	explosion1.position = position
	# actualizando score 
	Global.score += 30
	if Global.score > Global.max_score:
		Global.max_score = Global.score
	queue_free()


func _on_Area2D_body_entered(body):
	#print("toque algo...")
	
	var operatoria = Global.operatoria
	
	if irreductible == false:
		if body.is_in_group('num_block'):
			#print("es un bloque, hacer " + str(numero) +" "+  str(operatoria) + " " + str(body.numero))
			

			if operatoria == "+":
				sumar(body.numero)
				createMiniNum("+",body.numero)
			else:
				restar(body.numero)
				createMiniNum("-",body.numero)
			
			body.destroy()
			
			if estado == "bajando" or estado == "quieto":
				estado = "subiendo"
				atacando = false
				$TimerGolpe.start()
			
		
		if body.is_in_group("tope"):
			#print(" toque un tope Llegue abajo")
			if body.funca:
				estado = "quieto"
				if atacando == false:
					atacando = true
					attack()
				
	if body.is_in_group("borde"):
		match zigzageo_dir:
			"der":
				zigzageo_dir = "izq"
			"izq":
				zigzageo_dir = "der"
	
	if body.is_in_group("irreduct"):
		#emit_signal("enemyVictory")
		speed = 285
		estado = "bajando"
		irreductible = true
		

func attack():
	print("Ataco " + str(numero) )

	if $TimerAttack.wait_time > 0.12:
		$TimerAttack.wait_time -= 0.012
		
	var quitar_vida = abs(numero)
	
	if atacando:
		if control != null:
			control.vida -= quitar_vida
			control.update_life()
	$TimerAttack.start()
	

func _on_TimerAttack_timeout():
	attack()


func _on_TextureButton_pressed():
	
	if numero > 0 and numero <11:
		restar(1)
		createMiniNum("-",1)
		
	elif numero < 0 and numero > -11:
		sumar(1)
		createMiniNum("+",1)


func createMiniNum(signo,num):
	var numMini = mininum.instance()
	get_parent().add_child(numMini)
	numMini.position = position
	numMini.set_text( signo + str(num) )



func _on_TimerGolpe_timeout():
	if estado == "subiendo":
		estado = "bajando"


func _on_enemy_enemyVictory():
	speed = 285
	estado = "bajando"
	irreductible = true


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemys"):
		#print ("!!!!!!!!!!!!-----___toque a otro enemigo___-----!!!!!!!!!!!!")
		print("otro numero: " + str(area.get_parent().numero) )
		
		print (str(position.y) < str(area.get_parent().position.y) )
		
		if  position.y < area.get_parent().position.y :
			var absorb = enemyabsorb.instance()
			get_parent().add_child(absorb)
			absorb.position = position
			absorb.target = self
			queue_free()
		else:
			numero = numero + area.get_parent().numero
			if area.get_parent().numero > 1 :
				createMiniNum("+",area.get_parent().numero)
			else:
				createMiniNum("-",area.get_parent().numero)
			update_num()
