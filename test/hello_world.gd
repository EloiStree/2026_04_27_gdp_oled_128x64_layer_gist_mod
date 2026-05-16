extends Node
func _ready():
	print("Hello Layer SSD1306")
	
func append_layer(array_128x64: Array[bool]) -> void:
	for i in range(8192):
		array_128x64[i] = i%16==0
