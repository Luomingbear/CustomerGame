extends Node


func _ready():
	read()

func read():
	return FileManager.parseCsvFile("res://game.csv")
	
