extends Node2D


#load the cardFaceDetails and default to the first card in that dictonary
var CD = CardDetails.new()
var CardFaceMap = CD.getCardFaceMap()
var curCard = 0

@export var _CardFace:String = CardFaceMap.keys()[curCard]
@export var FaceUp:bool = true

var selected:bool = false




# Called when the node enters the scene tree for the first time.
func _ready():
	setCardFace(_CardFace)

func showCardFace():
	$AnimatedSprite2D.animation = CardFaceMap[_CardFace]["suit"]
	$AnimatedSprite2D.frame = CardFaceMap[_CardFace]["frame"]
	
func showCardBack():
	$AnimatedSprite2D.animation = "cardBack"
	$AnimatedSprite2D.frame = 1


func setCardFace(CardFace:String):
	_CardFace = CardFace
	if FaceUp:
		showCardFace()
	else:
		showCardBack()

	
func flipCard():
	FaceUp = !FaceUp
	if FaceUp:
		showCardFace()
	else:
		showCardBack()
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		self.position = get_global_mouse_position()
		print(self.position)
	
	
func nextCard():
	curCard += 1
	if curCard < len(CardFaceMap.keys()):
		setCardFace(CardFaceMap.keys()[curCard])
	else:
		curCard = 0
		setCardFace(CardFaceMap.keys()[curCard])

"""
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			flipCard()
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selected = !selected

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selected = false
"""
