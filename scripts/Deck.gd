extends Control

@export var card_scene_path = "res://scenes/card.tscn"
@export var start_position = Vector2(140,75)
@export var cut1_position = Vector2(550,75)
@export var rejoin_position = Vector2(205,75)
@export var deck_y = 75

var cards = []
var cuts = []
var card_scene
var cut_index = 0;
var random
var riffle_frequency = [1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,4,4,5]
# Called when the node enters the scene tree for the first time.
func _ready():
	var center_x = get_viewport_rect().size.x / 2
	self.start_position = Vector2(center_x-200, deck_y)
	self.cut1_position = Vector2(center_x+200, deck_y)
	self.rejoin_position = Vector2(center_x, deck_y)
	self.card_scene = load(card_scene_path)
	self.cards = []
	randomize()
	self._generate_deck()
	get_node("%FaceView").populate_cards(self.cards)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func cut():
	print('cutting deck')
	pass

	
func riffle():
	var cnt = 0;
	self.cut_index = 22 + randi() % 7
	
	for i in range(self.cut_index, 52):
		cards[i].position.y -= 30
		cards[i].target_position = cut1_position - Vector2(cnt/2.0, cnt/2.0)
		cnt += 1
	$riffle_cut_timer.start()

func _on_riffle_cut_timer_timeout():
	for card in cards:
		card.turn_horizontal()
		$spin_timer.start()

func _on_spin_timer_timeout():

	var shuffled = [];
	print(cards)
	var left_deck = cards.slice( 0, self.cut_index)
	var right_deck = cards.slice(self.cut_index);
	print("Left")
	print(left_deck)
	print("Right")
	print(right_deck)
	
	var lindex = 0
	var rindex = 0
	
	var skip_left = false
	#sometimes, the right side should go first
	if(randf()>.5):
		skip_left = true
	
	while(shuffled.size() < 52):
		if(left_deck.size() > 0 and skip_left==false):
			var freq = riffle_frequency.pick_random()
			for i in range(freq):
				if(left_deck.size() > 0):
					shuffled.append(left_deck.pop_front())
		if(right_deck.size() > 0):
			var freq = riffle_frequency.pick_random()
			for i in range(freq):
				if(right_deck.size() > 0):
					shuffled.append(right_deck.pop_front())
		skip_left = false
	print("Shuffled")
	print(shuffled)
	self.cards = shuffled

	#need to remove and readd to get ordering right
	for node in $card_frame.get_children():
		$card_frame.remove_child(node)
	
	var cnt = 0
	for card in cards:
		$card_frame.add_child(card)
		card.target_position = rejoin_position - Vector2(cnt/2.0, cnt/2.0)
		cnt+=1
		
	$merge_timer.start()
	get_node("%FaceView").update_positions(self.cards)
	
func _on_merge_timer_timeout():
	var cnt = 0
	for card in cards:
		card.target_position = start_position - Vector2(cnt/2.0, cnt/2.0)
		card.turn_vertical()
		cnt+=1
	
			
func _generate_deck():
	self.cards = []
	var deal_index = 0
	for suit in ["spades", "diamonds", "clubs", "hearts"]:
		for rank in range(1, 14):
			#create card here
			var card_instance = self.card_scene.instantiate()
			card_instance.deal_index = deal_index
			card_instance.suit = suit
			card_instance.rank = rank
			var face = str(rank)
			
			#catch the 4 corner cases
			match rank:
				1:
					face = "A"
				11:
					face = "J"
				12:
					face = "Q"
				13:
					face = "K"
			card_instance.face = face
			card_instance.target_position = start_position - Vector2(deal_index/2.0, deal_index/2.0)
			card_instance.face_down()
			$card_frame.add_child(card_instance)
			cards.append(card_instance)
			deal_index+=1
			


