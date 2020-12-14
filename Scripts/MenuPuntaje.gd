extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var admob = get_node("/root/Escena/AdMob")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel.visible = false
	$ColorRect.visible = false

func show():
	$ColorRect.visible = true
	$Panel.visible = true
	$Panel/Max.text = String(Global.max_score)
	$Panel/Actual.text = String(Global.score)


func _on_Volver_button_down():
	admob.show_interstitial()
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
