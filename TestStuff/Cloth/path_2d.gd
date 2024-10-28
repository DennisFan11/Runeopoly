extends Path2D
func get_point_arr(count:int)-> PackedVector2Array:
	var arr:PackedVector2Array = []
	for i in range(count+1):
		$PathFollow2D.progress_ratio = i/float(count+1)
		arr.append($PathFollow2D.global_position)
	return arr
