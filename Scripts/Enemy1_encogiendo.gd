extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var factorEncojiendo = 0.65
var rotationvalue =  3.25
var speed = 65
var target
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	scale.x -= factorEncojiendo * delta
	scale.y -= factorEncojiendo * delta
	
	if scale.x < 0.5:
		queue_free()
		
	if target != null:
		print ("siquiendo target " + str(target.position))
		velocity = position.direction_to(target.position) * speed
	velocity = move_and_slide(velocity)
		
	$aranani.rotation += rotationvalue  * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
