extends Control

@export var rank = 0
@export var face = ""
@export var suit = ""
@export var deck_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self._show_card()
	


func _show_card():
	var face_text = "[center]" + face + "[/center]"
	$FacePanel/LeftFace.text = face_text
	$FacePanel/RightFace.text = face_text
	$FacePanel/CenterFace.text = face_text
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

