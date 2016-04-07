part of brawl;

/// A single player object
///
/// Represents a single player that can belong to a game.
/// Handles player-related actions and deck/hand/board manipulation.
class Player extends Object with Events {
  /// The user-chosen name of this Player.
  String name;

  /// The `Game` instance this Player belongs to.
  Game game;

  /// The opposing player object for this Player
  Player opponent;

  /// The amount of mana left for the current turn
  int mana = 0;

  /// The amount of mana slots per turn
  int manaSlots = 0;

  /// The current board of creatures for this player
  List<Creature> board = [];

  /// The current hand of cards for this player
  /// TODO: Change this to Card when Card object is done.
  List<Card> hand = [];

  /// The remaining deck of cards for this player
  CardDeck deck;

  /// Create a new player with a given [name] that belongs to [game].
  /// TODO: Rulesets should handle initial player attributes
  Player(this.name, this.deck) {
    // Reset mana on turn start
    this.on(GameEventTurnStart, (e) {
      this.gainManaSlots(1);
      this.mana = this.manaSlots;
    });
  }

  // MARK: Mana Handling

  /// Gives an [amount] of mana this turn
  int gainMana(int amount) =>
    this.mana = Math.min(this.manaSlots, this.mana + amount);

  /// Gives an [amount] of mana slots
  int gainManaSlots(int amount) =>
    this.manaSlots = Math.min(10, this.manaSlots + amount);

  /// Destroys an [amount] of mana slots
  void destroyManaSlots(int amount) {
    this.manaSlots = Math.max(0, this.manaSlots - amount);
    if (this.mana > this.manaSlots)
      this.mana = this.manaSlots;
  }

  // MARK: Deck and Hand

  /// Returns whether the player's [hand] is too full of cards.
  bool isHandFull() => this.hand.length == 10;

  /// Handle the player's deck being out of cards
  void handleOutOfCards() => print("Player.handleOutOfCards ${this.hand}");

  /// Handle the player's hand being too full of cards.
  void handleHandFull() => print("Player.handleHandFull");

  /// Draw a [Card] from the player's deck and add it to [hand].
  Card drawCard() {
    // Handle out of cards
    if (this.deck.isOutOfCards()) { this.handleOutOfCards();
      return null;
    }

    // Handle full hand
    if (this.isHandFull()) { this.handleHandFull();
      return null;
    }

    // Draw a card
    var card = this.deck.drawCard();
    this.hand.add(card);

    // Emit event
    var event = new GameEventDrawCard(this, card);
    this.game.emit(event);

    return card;
  }

  // MARK: Cards

  /// Play the [Card] from hand at index [index].
  void playCardAtIndex(int index, {Character target: null, int targetIndex: null}) {
    // Get the card we're playing.
    final card = this.hand.elementAt(index);

    // Deduct mana cost for said card and remove from hand.
    this.mana -= card.cost;
    this.hand.remove(card);

    // Handle different type cases.
    switch (card.type) {
      // CreatureCard objects are summoned to an index on the board.
      case CardType.CREATURE:
        this.playCreatureCardToIndex(card, targetIndex: targetIndex);
        break;
      // SpellCard objects can be targeted on another character.
      case CardType.SPELL:
        this.playSpellCardToTarget(card, target: target);
        break;
    }
  }

  /// Play [card] onto the player's [board] at [targetIndex] or rightmost.
  void playCreatureCardToIndex(CreatureCard card, {int targetIndex: null}) {
    // Create a new creature from the card
    var creature = new Creature.fromCard(card, this);

    // Insert into specific index or at the end of the board (right side).
    if (targetIndex != null) {
      this.board.insert(targetIndex, creature);
    }
    else {
      this.board.add(creature);
    }

    // Send PlayCard event
    final playEvent = new GameEventPlayCard(this, card);
    creature.emit(playEvent);
    this.game.emit(playEvent);

    // Send SummonCreature event
    final summonEvent = new GameEventSummonCreature(this, creature, targetIndex);
    creature.emit(summonEvent);
    this.game.emit(summonEvent);
  }

  // Play [card] to an optional [Character] [target].3
  void playSpellCardToTarget(SpellCard card, {Character target: null}) {
    final playEvent = new GameEventPlayCard(this, card);
    this.game.emit(playEvent);

    final castEvent = new GameEventCastSpell(this, card, target);
    this.game.emit(castEvent);
  }

  // MARK: Games

  /// Adds the player to [game], if it isn't already there.
  bool joinGame(Game game) {
    if (!game.players.contains(this)) {
      this.game = game;
      game.players.add(this);
      return true;
    }
    return false;
  }

  /// Removes the player from the current [game].
  bool leaveGame() {
    if (game.players.contains(this)) {
      this.game = null;
      this.game.players.remove(this);
      return true;
    }
    return false;
  }
}