extends Node2D

var cardWidth = Vector2(50,0)
@export var PlayerName:String = "Player1"
@export var MaxHandSize : int = 5
var Cards = []


# Called when the node enters the scene tree for the first time.
func _ready():
	setPlayerLabel()
	drawCardsInHand()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func drawCardsInHand():
	var HandPOS = 0
	for card in Cards:
		card.position = $MyCards.position + (cardWidth * HandPOS )
		HandPOS += 1


func setPlayerLabel():
	$PlayerLabel.text = PlayerName + " - " + str(len(Cards)) + "/" + str(MaxHandSize) + " Cards"


func addCard(Card):
	Cards.append(Card)
	$MyCards.add_child(Card)
	setPlayerLabel()
	drawCardsInHand()
