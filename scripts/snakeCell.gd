class_name SnakeCell

var currPosition := Vector2() : set = _set_curr_position
var prevPosition := Vector2()
var size := Vector2()
var color := Color()


func get_rect() -> Rect2:
	return Rect2(currPosition, size)


func _set_curr_position(newPosition: Vector2) -> void:
	prevPosition = currPosition
	currPosition = newPosition
