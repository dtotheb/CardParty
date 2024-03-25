extends Node2D
var Cards = []
#load the cardFaceDetails and default to the first card in that dictonary
var CD = CardDetails.new()
var CardFaceMap = CD.getCardFaceMap()

# Called when the node enters the scene tree for the first time.
func _ready():
	Cards = []
	$AnimatedSprite2D.animation = "cardBack"
	$AnimatedSprite2D.frame = 0
	setDiscardPileLabel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func setDiscardPileLabel():
	$Label.text = str(len(Cards)) + " Cards"
	
func showCardFace(cardFace):
	$AnimatedSprite2D.animation = CardFaceMap[cardFace]["suit"]
	$AnimatedSprite2D.frame = CardFaceMap[cardFace]["frame"]
	
func highLight():
	$AnimatedSprite2D.scale = Vector2(1.1,1.1)
	$AnimatedSprite2D.modulate = Color(0.75,0,0)
	
func unhighLight():
	$AnimatedSprite2D.scale = Vector2(1,1)
	$AnimatedSprite2D.modulate = Color(1,1,1)
	
func getTopCard():
	if len(Cards) > 0:
		return Cards[-1]
	else:
		return null

func addCard(Card):
	Cards.append(Card._CardFace)
	print(Cards)
	showCardFace(Card._CardFace)
	setDiscardPileLabel()
	
