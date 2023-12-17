extends Control

@export var card_scene_path = "res://scenes/smallcard.tscn"
@export var start_position = Vector2(140,700)

var card_scene
var card_positions = []
var mini_by_deal = []
var card_width = 36
var card_buffer = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func populate_positions():
	var center_x = get_viewport_rect().size.x / 2
	var bottom_y = get_viewport_rect().size.y - 150
	var start_x = center_x - ((card_width + card_buffer) * 26)
	self.start_position = Vector2(start_x, bottom_y)
	for i in range(0, 52):
		var x = start_x + ((card_width + card_buffer) * i)
		self.card_positions.append(Vector2(x, bottom_y))
			
func populate_cards(deck_cards:Array):
	self.populate_positions()
	self.card_scene = load(card_scene_path)
	var i = 0
	for card in deck_cards:
		var card_instance = self.card_scene.instantiate()
		card_instance.build_from_card(card)
		card_instance.target_position = self.card_positions[i]
		i+=1
		$card_frame.add_child(card_instance)
		mini_by_deal.append(card_instance)
		
func update_positions(deck_cards:Array):
	var index = 0
	
	for card in deck_cards:
		var mini = self.mini_by_deal[card.deal_index]
		mini.target_position = self.card_positions[index]
		index+=1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
