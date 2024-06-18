extends Node


const GRID_SIZE := Vector2(960, 640)
const CELL_SIZE := Vector2(32, 32)

const CELLS_COUNT := Vector2(GRID_SIZE.x / CELL_SIZE.x, GRID_SIZE.y / CELL_SIZE.y)

const LEFT_BORDER := 0
const RIGHT_BORDER := GRID_SIZE.x - CELL_SIZE.x
const TOP_BORDER := 0
const BOTTOM_BORDER := GRID_SIZE.y - CELL_SIZE.y

const INIT_SCORE = 5

var score := 0 : set = _set_score

signal score_changed(newScore: int)


func _set_score(newScore: int) -> void:
	score = newScore
	score_changed.emit(newScore)
