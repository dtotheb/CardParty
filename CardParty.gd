extends Node2D
@export var CardStyle:PackedScene



var activePlayer:int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func highlightDropZones():
	$DiscardPile.highLight()
	
func unhighlightDropZones():
	$DiscardPile.unhighLight()


func _on_deck_draw_card(cardFace):
	print("Drew: ", cardFace)
	var newCard = CardStyle.instantiate()
	newCard._CardFace = cardFace
	newCard.card_selected.connect(highlightDropZones)
	newCard.card_unselected.connect(unhighlightDropZones)
	if activePlayer == 1:	
		$PlayerHand1.addCard(newCard)
	else:
		$PlayerHand2.addCard(newCard)

	activePlayer = activePlayer * -1
