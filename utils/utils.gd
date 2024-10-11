extends Node


func transform_float_to_percent(number: float) -> String:
	var percent = str(number * 100) + "%"
	
	return percent
