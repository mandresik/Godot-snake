class_name Snake extends Node2D

var head := SnakeCell.new()
var snake := [] as Array[SnakeCell]

var currDirection := Vector2.RIGHT
var nextDirection := Vector2.RIGHT

var tweenMove: Tween

var score: int

signal hit(snakeCellHit: SnakeCell) 


func _ready():
	head.size = Game.CELL_SIZE
	head.color = Colors.RED 
	head.currPosition = Vector2(Game.GRID_SIZE.x / 2, Game.GRID_SIZE.y / 2)
	snake.push_front(head)               
	score = 0
	for i in range(Game.INIT_SCORE): grow()
	
	hit.connect(onHit)
	
	tweenMove = create_tween().set_loops()
	tweenMove.tween_callback(move).set_delay(0.1)


func _process(delta):
	queue_redraw()


func _draw():
	for snakeCell in snake:
		draw_rect(snakeCell.get_rect(), snakeCell.color)


func _input(event):
	if event.is_action_pressed("move_left") and currDirection != Vector2.RIGHT:
		nextDirection = Vector2.LEFT
	if event.is_action_pressed("move_right") and currDirection != Vector2.LEFT:
		nextDirection = Vector2.RIGHT
	if event.is_action_pressed("move_up") and currDirection != Vector2.DOWN:
		nextDirection = Vector2.UP
	if event.is_action_pressed("move_down") and currDirection != Vector2.UP:
		nextDirection = Vector2.DOWN
		
	# test for snake grow ... hitting space makes snake grow
	if event.is_action_pressed("grow"): grow()


func move() -> void: 
	currDirection = nextDirection
	var nextPosition = head.currPosition + (currDirection * Game.CELL_SIZE)
	check_collision(nextPosition)
	head.currPosition = nextPosition
	
	for i in range(1, snake.size()):
		snake[i].currPosition = snake[i - 1].prevPosition


func check_collision(nextPosition: Vector2) -> void:
	if (nextPosition.x == Game.LEFT_BORDER or nextPosition.x == Game.RIGHT_BORDER or 
		nextPosition.y == Game.TOP_BORDER or nextPosition.y == Game.BOTTOM_BORDER):
		# print("out of plane")
		hit.emit(snake[0])
	
	# there is initially head-body collision while creating snake
	if score <= Game.INIT_SCORE: return
	for i in range(1, snake.size()):
		if snake[i].currPosition == head.currPosition:
			# print("head-body collision")
			hit.emit(snake[i])


func grow() -> void:
	score += 1
	var newSnakeCell := SnakeCell.new()
	var lastSnakeCell := snake.back() as SnakeCell
	
	newSnakeCell.currPosition = lastSnakeCell.currPosition
	newSnakeCell.color = Colors.GREEN
	newSnakeCell.size = Game.CELL_SIZE
	snake.push_back(newSnakeCell)


func onHit(snakeCell: SnakeCell) -> void:
	tweenMove.kill()
