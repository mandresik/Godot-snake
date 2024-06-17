class_name SnakeCell

var currPosition := Vector2()
var size := Vector2()
var color := Color()

func get_rect() -> Rect2:
	return Rect2(currPosition, size)
