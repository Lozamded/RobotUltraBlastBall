extends Node2D

func _ready():
	$fuego.emitting = true
	$fuego/chispa.emitting = true
	$fuego/humo.emitting = true

func _on_Timer_timeout():
	queue_free()
