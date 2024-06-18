extends Node2D

var food := Food.new()
@onready var snake := %snake as Snake 


func _ready():
	spawn_food()


func _process(delta):
	queue_redraw()
	
	if food.get_rect().intersects(snake.head.get_rect()):
		snake.grow()
		spawn_food()


func _draw():
	draw_rect(food.get_rect(), food.color)


func spawn_food() -> void:
	var isOnOccupiedPosition = true
	
	while isOnOccupiedPosition:
		var randomPosition = Vector2()
		randomPosition.x = randi_range(Game.LEFT_BORDER + Game.CELL_SIZE.x, Game.RIGHT_BORDER - Game.CELL_SIZE.x)
		randomPosition.y = randi_range(Game.TOP_BORDER + Game.CELL_SIZE.y, Game.BOTTOM_BORDER - Game.CELL_SIZE.y)
		food.position = randomPosition.snapped(Game.CELL_SIZE)
		
		for snakeCell in snake.snake:
			if food.get_rect().intersects(snakeCell.get_rect()):
				isOnOccupiedPosition = true
				break
			else:
				isOnOccupiedPosition = false
