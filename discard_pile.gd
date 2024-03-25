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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func showCardFace(cardFace):
	$AnimatedSprite2D.animation = CardFaceMap[cardFace]["suit"]
	$AnimatedSprite2D.frame = CardFaceMap[cardFace]["frame"]
	
func highLight():
	scale = Vector2(1.2,1.2)
	
func unhighLight():
	scale = Vector2(1,1)

func playCard(cardFace):
	print(cardFace + " played")
	showCardFace(cardFace)
