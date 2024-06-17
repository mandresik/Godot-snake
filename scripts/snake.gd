extends Node2D

var head := SnakeCell.new()

var currDirection := Vector2.RIGHT
var nextDirection := Vector2.RIGHT

var tweenMove: Tween


func _ready():
	head.size = Game.CELL_SIZE
	head.color = Colors.RED 
	
	tweenMove = create_tween().set_loops()
	tweenMove.tween_callback(move).set_delay(0.1)

func _process(delta):
	queue_redraw()


func _draw():
	draw_rect(head.get_rect(), head.color)

func _input(event):
	if event.is_action_pressed("move_left") and currDirection != Vector2.RIGHT:
		nextDirection = Vector2.LEFT
	if event.is_action_pressed("move_right") and currDirection != Vector2.LEFT:
		nextDirection = Vector2.RIGHT
	if event.is_action_pressed("move_up") and currDirection != Vector2.DOWN:
		nextDirection = Vector2.UP
	if event.is_action_pressed("move_down") and currDirection != Vector2.UP:
		nextDirection = Vector2.DOWN


func move() -> void: 
	currDirection = nextDirection
	var nextPosition = head.currPosition + (currDirection * Game.CELL_SIZE)
	check_bounds(nextPosition)
	head.currPosition = nextPosition

func check_bounds(nextPosition: Vector2) -> void:
	if (nextPosition.x == Game.LEFT_BORDER or nextPosition.x == Game.RIGHT_BORDER or 
		nextPosition.y == Game.TOP_BORDER or nextPosition.y == Game.BOTTOM_BORDER):
		print("out of plane")
