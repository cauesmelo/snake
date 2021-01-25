extends MarginContainer

const mainGame = preload("res://GameScreen.tscn")

onready var selectorOne = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/arrow
onready var selectorTwo = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/arrow
onready var selectorThree = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/arrow

var currentSelect = 0

func _ready():
	setSelect(0)

func setSelect(currentSelect):
	selectorOne.text = ""
	selectorTwo.text = ""
	selectorThree.text = ""
	if currentSelect == 0:
		selectorOne.text = ">"
	elif currentSelect == 1:
		selectorTwo.text = ">"
	elif currentSelect == 2:
		selectorThree.text = ">"

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		if(currentSelect < 2):
			currentSelect += 1
			setSelect(currentSelect)
		
	if Input.is_action_just_pressed("ui_up"):
		if(currentSelect > 0):
			currentSelect -= 1
			setSelect(currentSelect)
	
	if Input.is_action_just_pressed("ui_accept"):
		Global.difficulty = currentSelect
		get_parent().add_child(mainGame.instance())
		queue_free()
