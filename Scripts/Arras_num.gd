extends KinematicBody2D

export var numero = 2
var estado = "esperando"
var dragging = false
var rapidez = 1000
var creadotro = false
var enzona = false
var encima = false

export var numerodebloque = 0

var	posini

signal dragsignal;
export  (NodePath) var controlpath
var control
var touch = false;

var bloquesumado

func _ready():
	
	update_num()
	
	posini = position
	
# warning-ignore:return_value_discarded
	connect("dragsignal",self,"_set_drag_pc")
	
	if controlpath != "":
		getControl()
	
func getControl():
	control = get_node_or_null(controlpath)
	
func _process(delta):
	if dragging:
		var mousepos = get_global_mouse_position()
		global_position = Vector2(mousepos.x, mousepos.y)
		
		if Input.is_action_just_released("click"):
			emit_signal("dragsignal")
		
	elif estado == "volando":
		 global_position.y -= rapidez * delta

func _set_drag_pc():
	dragging=!dragging
	#print("draggin" + str(dragging))
	
	if dragging == false and estado=="esperando":
		#print("volar")
		
		if enzona == false:
			estado = "volando"
			
			if creadotro == false:
				crearbloque()
		else:
			if(encima):
				var operatoria = Global.operatoria
				
				if bloquesumado != null:
					print (str(numero) + " " + operatoria + " " + str(bloquesumado.numero) )
					if operatoria == "+":
						bloquesumado.sumar(numero)
					elif operatoria == "-":
						if(bloquesumado.numero > numero):
							bloquesumado.numero =  bloquesumado.numero - numero
						else:
							bloquesumado.numero =  numero - bloquesumado.numero
						bloquesumado.update_num()
						#bloquesumado.restar(numero)
					destroy()
				else:
					position = posini
			else:
				position = posini

	
func update_num_specific(num):
	$numero.text = str(num)
	
func update_num():
	$numero.text = str(numero)
	
	if(numero == 0):
		destroy()
	
func restar(num):
	numero -= num
	update_num()
	
func sumar(num):
	numero += num
	update_num()
	
func destroy():
	if creadotro == false:
		crearbloque()
	queue_free()
	
func anunciar():
	print ("hola soy el bloque " + str(name) + " creado en " + str(position) + " | global " + str(global_position) ) 
	
func _input(event):
	if touch:
		if event is InputEventScreenTouch:
			if not event.pressed:
				touch = false
				emit_signal("dragsignal")
	
func _on_ArrasBloque_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
			
	elif event is InputEventScreenTouch:
		if event.pressed:
			self.global_position = event.get_position()
			dragging = true
			touch = true
			
			
func crearbloque():
	#print ("Crear otro " + str(posini) )
	var otroBloque = load("res://Objects/ArrasBloque.tscn").instance()
	get_parent().call_deferred("add_child",otroBloque)
	otroBloque.position = posini
	otroBloque.posini = posini
	
	if numero == 1:
		otroBloque.numero = 1
	else:
		otroBloque.resetbloque()
		
	otroBloque.numerodebloque = numerodebloque
	
	if controlpath != "":
		otroBloque.controlpath = controlpath
		otroBloque.getControl()
		
		match numerodebloque:
			1 : 
				print("crear bloque 1")
				control.bloque1 = otroBloque
			2 : 
				print("crear bloque 3")
				control.bloque2 = otroBloque
			3:
				print("crear bloque 4")
				control.bloque3 = otroBloque
			
	creadotro = true
	otroBloque.creadotro = false
	otroBloque.update_num()
	
func resetbloque():

	numero = randi()% 12 + 2

	#Numeros negativos
	#var signo = randi()% 6 + 1
	#if signo < 3:
	#	numero *= -1
	
	update_num()
	
	
	#otroBloque.anunciar()


func _on_Area2D_body_entered(body):
	if body.is_in_group('num_block'):
		if body.estado == "esperando":
			#print("encima de otro bloque")
			bloquesumado = body
			encima = true
			
	if body.is_in_group('block_desrtructor'):
		#creadotro = true
		#print("sali de la pantalla y no toque nada")
		if Global.score > 0:
			Global.score-=10
		destroy()

func _on_Area2D_body_exited(body):
	if body.is_in_group('num_block'):
			#print("sali del otro bloque")
			bloquesumado = null
			encima = false
