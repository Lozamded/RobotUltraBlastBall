extends Node2D


var vida = 100


var bloque1
var bloque2
var bloque3

var perder = false
var explosion = preload("res://Particles/Explosion.tscn")




export (NodePath) var MenuPath
export (NodePath) var TimerEnemyPath
export (NodePath) var topePath
export (NodePath) var irreducPath 

onready var Menu = get_node(MenuPath)
onready var TimerEnemy = get_node(TimerEnemyPath)
onready var admob = get_node("/root/Escena/AdMob")
onready var puntaje = get_node("/root/Escena/Puntaje")
onready var tope = get_node(topePath)
onready var irreduc = get_node(irreducPath)
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	bloque1 = $ArrasBloque1
	bloque2 = $ArrasBloque2
	bloque3 = $ArrasBloque3

func update_life():
	$VidaPlayer.value = vida
	
func update_golpes():
	$Golpes.update_golpes()

func GameOver():
	puntaje.show()
		



func _on_Start_pressed():
	visible = true
	print("comenzar")
	Menu.get_node("Control").visible = false
	#tope.funca = true
	#irreduc.resetpos()
	#TimerEnemy.start()



func _on_Explosiones_timeout():
	print("Crear explosión")
	var explosion1 = explosion.instance()
	get_parent().add_child(explosion1)
	explosion1.position = Vector2(rand_range(100,700),rand_range(1000,1600))
	$Explosiones.start()


func _on_GameOver_timeout():
	print("GAME OVER")
	GameOver()
