extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_blocks_zone_body_entered(body):
	if body.is_in_group('num_block'):
		body.enzona = true

func _on_blocks_zone_body_exited(body):
	if body.is_in_group('num_block'):
		body.enzona = false
