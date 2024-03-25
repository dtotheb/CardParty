extends Node2D
@export var CardStyle:PackedScene



var activePlayer:int = 1
var playerMap

func setupPlayerMap():
	var player1 = get_node("PlayerHand1")
	var player2 = get_node("PlayerHand2")
	return { 1 : player1, -1: player2 }

# Called when the node enters the scene tree for the first time.
func _ready():
	playerMap = setupPlayerMap()
	highlightActivePlayer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_card_select_attempted(Card):
	print(Card._CardFace + " selected")
	$DiscardPile.highLight()
	#check if selectedCard is owned by the ActivePlayer's Hand:
	if Card.get_parent().get_parent().PlayerName == playerMap[activePlayer].PlayerName:
		print("card owned by activePlayer")
		Card.selectCardSuccessful()
	else:
		Card.selectCardUnSuccessful()
		$DiscardPile.unhighLight()
		print("card owned by inactivePlayer")

func _on_card_unselect_attempted(Card):
	var current_mouse_pos = get_global_mouse_position()
	var discard_pile_pos = $DiscardPile.global_position
	var dropZoneDistance = 50
	
	var dis_to_discard_pile = current_mouse_pos.distance_to(discard_pile_pos)
	if dis_to_discard_pile < dropZoneDistance:
		print("inside DropZone")
		playerMap[activePlayer].removeCard(Card)
		switchActivePlayer()

		
		$DiscardPile.playCard(Card)
		Card.queue_free()
	
	$DiscardPile.unhighLight()
	
func highlightActivePlayer():
	print("Active Player: " + playerMap[activePlayer].PlayerName)
	playerMap[activePlayer].highlightPlayer()
	playerMap[activePlayer * -1].unhighlightPlayer()
	
	
func switchActivePlayer():
	activePlayer = activePlayer * -1
	highlightActivePlayer()
	
func _on_deck_draw_card(cardFace):
	print("Drew: ", cardFace)
	var newCard = CardStyle.instantiate()
	newCard._CardFace = cardFace
	newCard.card_select_attempted.connect(_on_card_select_attempted)
	newCard.card_unselect_attempted.connect(_on_card_unselect_attempted)
	playerMap[activePlayer].addCard(newCard)
	switchActivePlayer()

