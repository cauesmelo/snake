extends Control

signal updateScore

onready var scoreText = $MarginContainer/HBoxContainer/HBoxContainer/scoreText
onready var difficultyText = $MarginContainer/HBoxContainer/HBoxContainer2/difficultyText
onready var gameNode = get_node("Game")
	
func _ready():
	if Global.difficulty == 0:
		difficultyText.text = "Easy"
	elif Global.difficulty == 1:
		difficultyText.text = "Medium"
	elif Global.difficulty == 2:
		difficultyText.text = "Hard"
	
	gameNode.connect("updateScore", self, "onUpdateScore")


func onUpdateScore():
	scoreText.text = str(Global.score)


