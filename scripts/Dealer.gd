extends Node

@export var deck: Node


var cuts = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Handle the user input
func _input(event) -> void:
	if(Input.is_action_just_pressed("cut-deck") && cuts == 0):
		print("Cut deck")
		deck.cut()
		cuts += 1
	if(Input.is_action_just_pressed("riffle")):
		print("riffle")
		deck.riffle()
		cuts = 0
		
	
