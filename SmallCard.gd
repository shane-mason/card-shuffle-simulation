extends Panel

@export var rank = 0
@export var face = ""
@export var suit = ""
@export var deal_index = 0
@export var color_code = "#000000"
var target_position = position
var target_rotation = rotation
var move_speed = 900
var rotation_dir = 1
var rotation_speed = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(target_position) > 1:
		position = position.move_toward(target_position, delta * move_speed)
	if rotation_degrees != target_rotation:
		rotation_degrees += rotation_dir * rotation_speed * delta
		if( abs(rotation_degrees-target_rotation) < 2):
			rotation_degrees = target_rotation

func build_from_card(card):
	self.rank = card.rank
	self.face = card.face
	self.suit = card.suit
	self.deal_index = card.deal_index
	self.color_code = card.color_code
	var texture = load(card.texture_path)
	
	$Suit.texture = texture
	$Suit.modulate = card.color_code
	
	var face_text = "[center][color=%s]%s[/color][/center]" % [self.color_code, self.face]
	$Face.text = face_text
	
func update_dist(dist:int):
	pass
		
