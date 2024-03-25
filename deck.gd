extends Node2D

var Cards = []
var CD = CardDetails.new()
var CardFaceMap = CD.getCardFaceMap("ancient")


# Called when the node enters the scene tree for the first time.
func _ready():
	generateDeck()
	

func setDeckSizeLabel(count):
	$Label.text = str(count) + " Cards"


func generateDeck(shuffle=true):
	Cards = []
	for card in CardFaceMap.keys():
			Cards.append(card)
	setDeckSizeLabel(len(Cards))
	if shuffle:
		Cards.shuffle()

func drawCard():
	if len(Cards) > 0:
		var topCard = Cards[0]
		Cards.remove_at(0)
		setDeckSizeLabel(len(Cards))
		return topCard
	else:
		print("Deck is Empty!")
		return null
	

func on_click():
	var newCard = drawCard()
	print(newCard)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func setCards(cardList):
	Cards = cardList

func get_CardCount():
	return len(Cards)


