extends Sprite

var dir = -1

func ready():
	$Area2D.add_to_group("espada")

func _process(delta):
	if rotation < 0 :
		dir = -1
		
	else: 
		dir = 1
