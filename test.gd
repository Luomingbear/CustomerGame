extends Node


func _ready():
	read()

func read():
	var file = File.new()
	file.open("res://test.csv", File.READ)
	
	var array = file.get_csv_line(";")
	return array
	
