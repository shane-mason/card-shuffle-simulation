extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _generate_deck():
	var deck_index = 0
	for suite in ["spades", "hearts", "clubs", "diamonds"]:
		for rank in range(13):
			#create card here
			deck_index+=1
