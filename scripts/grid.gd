extends Node2D


func _ready():
	pass 


func _process(delta):
	pass

func _draw() -> void:
	# background
	draw_rect(Rect2(0, 0, Game.GRID_SIZE.x, Game.GRID_SIZE.y), Colors.WHITE)
	
	# vertical lines
	for i in Game.CELLS_COUNT.x:
		var from := Vector2(i * Game.CELL_SIZE.x, 0)
		var to := Vector2(from.x, Game.GRID_SIZE.y)
		draw_line(from, to, Colors.GREY)
	
	# horizontal lines
	for i in Game.CELLS_COUNT.y:
		var from := Vector2(0, i * Game.CELL_SIZE.y)
		var to := Vector2(Game.GRID_SIZE.x, from.y)
		draw_line(from, to, Colors.GREY)
	
	# borders
	draw_rect(Rect2(0, 0, Game.GRID_SIZE.x, Game.CELL_SIZE.y), Colors.DARK_GREY)
	draw_rect(Rect2(0, Game.GRID_SIZE.y - Game.CELL_SIZE.y, Game.GRID_SIZE.x, Game.CELL_SIZE.y), Colors.DARK_GREY)
	draw_rect(Rect2(Game.GRID_SIZE.x - Game.CELL_SIZE.x, 0, Game.CELL_SIZE.x, Game.GRID_SIZE.y), Colors.DARK_GREY)
	draw_rect(Rect2(0, 0, Game.CELL_SIZE.x, Game.GRID_SIZE.y), Colors.DARK_GREY)
