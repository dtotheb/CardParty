extends Node2D


#load the cardFaceDetails and default to the first card in that dictonary
var CD = CardDetails.new()
var CardFaceMap = CD.getCardFaceMap()
var curCard = 0

@export var _CardFace:String = CardFaceMap.keys()[curCard]
@export var FaceUp:bool = true

var selected:bool = false
signal card_select_attempted(cardFace)
signal card_unselect_attempted(cardFace)
var mouse_in = false
var score = 0
var CardPOSatSelectAttempt:Vector2



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
	score = CardFaceMap[CardFace]["score"]
	if FaceUp:
		showCardFace()
	else:
		showCardBack()
		
		
func getCardFace():
	return _CardFace

	
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
		
		
func selectCardAttempted():
	CardPOSatSelectAttempt = global_position
	emit_signal("card_select_attempted", self)
	
func selectCardSuccessful():
	selected = true
	self.z_index = 1

func selectCardUnSuccessful():
	selected = false
	self.z_index = 0
	
func unselectCardAttempted():
	selected = false
	self.z_index = 0
	emit_signal("card_unselect_attempted", self)

func unselectCardSuccessful():
	print("invalid Play returning card to hand")
	global_position = CardPOSatSelectAttempt
	selected = false
	self.z_index = 0

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			flipCard()
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if mouse_in:
				selectCardAttempted()
		else:
			unselectCardAttempted()
			
			


			
func _on_area_2d_mouse_entered():
	mouse_in = true
	scale = Vector2(1.1,1.1)
	
func _on_area_2d_mouse_exited():
	mouse_in = false
	scale = Vector2(1,1)


