extends Node2D

const SNAKE = 1
const APPLE = 0
var score = 0
var applePos
var snakeBody = [Vector2(5, 10), Vector2(4, 10), Vector2(3, 10)]
var snakeDirection = Vector2(1, 0)
var rng = RandomNumberGenerator.new()
var timer



func _ready():
	applePos = placeApple()
	timer = get_node("Timer")
	timer.set_wait_time(0.2)
	

func placeApple():
	rng.randomize()
	var x = rng.randi_range(0, 31)
	var y = rng.randi_range(0, 19)
	while($SnakeApple.get_cell(x, y) == 1):
		x = rng.randi_range(0, 31)
		y = rng.randi_range(0, 19)
	return Vector2(x, y)

func drawApple():
	$SnakeApple.set_cell(applePos.x, applePos.y, APPLE)
	

func drawSnake():
	for block in snakeBody:
		$SnakeApple.set_cell(block.x, block.y, SNAKE, false, false, false, Vector2(8, 0))


func deleteTiles(id:int):
	var cells = $SnakeApple.get_used_cells_by_id(id)
	for cell in cells:
		$SnakeApple.set_cell(cell.x, cell.y, -1)
		

func _input(_event):
	if (Input.is_action_just_pressed("ui_up") && snakeDirection != Vector2(0, 1)): snakeDirection = Vector2(0, -1)
	if (Input.is_action_just_pressed("ui_right") && snakeDirection != Vector2(-1, 0)): snakeDirection = Vector2(1, 0)
	if (Input.is_action_just_pressed("ui_left") && snakeDirection != Vector2(1, 0)): snakeDirection = Vector2(-1, 0)
	if (Input.is_action_just_pressed("ui_down") && snakeDirection != Vector2(0, -1)): snakeDirection = Vector2(0, 1)

func moveSnake():
	var bodyCopy = snakeBody.slice(0, snakeBody.size() - 2)
	var newHead = bodyCopy[0] + snakeDirection
	
		# check collision
	if($SnakeApple.get_cell(newHead.x, newHead.y) == 1):
		return false
	if(newHead.x < 0 || newHead.x > 31):
		return false
	if(newHead.y < 0 || newHead.y > 19):
		return false
	deleteTiles(SNAKE)
	bodyCopy.insert(0, newHead)
	snakeBody = bodyCopy
	return true

func _on_Timer_timeout():
	drawApple()
	if(checkApple()):
		if(!growSnake()):
			gameOver()
	else:
		if(!moveSnake()):
			gameOver()
	
	drawSnake()
		

func checkApple():
	if applePos == snakeBody[0]:
		applePos = placeApple()
		score += 1
		return true
	return false


func growSnake():
	var lastPos = snakeBody[-1]
	var collision = moveSnake()
	snakeBody.append(lastPos)
	return collision

func gameOver():
	print("game over")

