extends Node2D

export var corresponde ="" 


func quitarvida(num):
	get_parent().get_parent().vida -= num
	get_parent().get_parent().update_life()
