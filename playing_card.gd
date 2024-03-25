extends Node2D


#load the cardFaceDetails and default to the first card in that dictonary
var CD = CardDetails.new()
var CardFaceMap = CD.getCardFaceMap()
var curCard = 0

@export var _CardFace:String = CardFaceMap.keys()[curCard]
@export var FaceUp:bool = true

var selected:bool = false
signal card_selected(cardFace)
signal card_unselected(cardFace)
var mouse_in = false




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
		global_position = get_global_mouse_position()
		
	
	
func nextCard():
	curCard += 1
	if curCard < len(CardFaceMap.keys()):
		setCardFace(CardFaceMap.keys()[curCard])
	else:
		curCard = 0
		setCardFace(CardFaceMap.keys()[curCard])
		
		
func selectCard():
	selected = true
	self.z_index = 1
	emit_signal("card_selected", self)
	
func unselectCard():
	selected = false
	self.z_index = 0
	emit_signal("card_unselected", self)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			flipCard()
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if mouse_in:
				selectCard()
		else:
			unselectCard()
			
			


			
func _on_area_2d_mouse_entered():
	mouse_in = true
	scale = Vector2(1.1,1.1)
	
func _on_area_2d_mouse_exited():
	mouse_in = false
	scale = Vector2(1,1)


