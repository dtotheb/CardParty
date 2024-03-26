extends Node2D

var cardWidth = Vector2(50,0)
@export var PlayerName:String = "Player1"
@export var MaxHandSize:int = 5
var CardsInHand:int = 0
var playerScore:int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	setPlayerLabel()
	drawCardsInHand()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func drawCardsInHand():
	var HandPOS = 0
	for card in $MyCards.get_children():
		if is_instance_valid(card):
			card.position = $MyCards.position + (cardWidth * HandPOS )
			HandPOS += 1


func setPlayerLabel():
	$PlayerLabel.text = PlayerName + " - " + str(playerScore) + " Points"

func highlightPlayer():
	$PlayerLabel.modulate = Color(1,0,0)
	
func unhighlightPlayer():
	$PlayerLabel.modulate = Color(1,1,1)
	

func addPointsToScore(points:int):
	playerScore = playerScore + points
	setPlayerLabel()

func addCard(Card):
	$MyCards.add_child(Card)
	CardsInHand += 1
	setPlayerLabel()
	drawCardsInHand()


func removeCard(Card):
	print("Removing " + Card._CardFace + " from " + PlayerName)
	CardsInHand -= 1
	Card.queue_free()
	drawCardsInHand()
	setPlayerLabel()
