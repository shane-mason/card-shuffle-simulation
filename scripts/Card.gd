extends Control

@export var rank = 0
@export var face = ""
@export var suit = ""
@export var deal_index = 0
@export var club_path = "res://img/clubs.png"
@export var heart_path = "res://img/hearts.png"
@export var diamond_path = "res://img/diamonds.png"
@export var spade_path = "res://img/spades.png"
@export var texture_path = "res://img/clubs.png"
@export var color_code = "#000000"
var target_position = position
var target_rotation = rotation
var move_speed = 700
var rotation_dir = 1
var rotation_speed = 180

# Called when the node enters the scene tree for the first time.
func _ready():
	self._build_card()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if position.distance_to(target_position) > 1:
		position = position.move_toward(target_position, delta * move_speed)
	if rotation_degrees != target_rotation:
		rotation_degrees += rotation_dir * rotation_speed * delta
		if( abs(rotation_degrees-target_rotation) < 2):
			rotation_degrees = target_rotation
		
func _to_string():
	return self.face + self.suit[0]
	
func turn_horizontal():
	target_rotation = 90
	rotation_dir = 1
	
func turn_vertical():
	target_rotation = 0
	rotation_dir = -1

func face_up():
	$BackPanel.visible = false
	$FacePanel.visible = true
	
func face_down():
	$BackPanel.visible = true
	$FacePanel.visible = false
	
func _build_card():
		
	match self.suit:
		"spades":
			self.texture_path = spade_path
			self.color_code = "#000000"
		"diamonds":
			self.texture_path = diamond_path
			self.color_code = "#FF0000"
		"clubs":
			self.texture_path = club_path
			self.color_code = "#000000"
		_:
			self.texture_path = heart_path
			self.color_code = "#FF0000"
			
	var texture = load(self.texture_path)
	$FacePanel/LeftSuit.texture = texture
	$FacePanel/LeftSuit.modulate = self.color_code
	$FacePanel/RightSuit.texture = texture
	$FacePanel/RightSuit.modulate = self.color_code
	$FacePanel/CenterSuit.texture = texture
	$FacePanel/CenterSuit.modulate = self.color_code
	
	var face_text = "[center][color=%s]%s[/color][/center]" % [self.color_code, self.face]
	$FacePanel/LeftFace.text = face_text
	$FacePanel/RightFace.text = face_text
	$FacePanel/CenterFace.text = face_text
	
	


