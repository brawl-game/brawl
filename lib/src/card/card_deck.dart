part of brawl;

class CardDeck {
  /// The given name of this deck of cards
  String name;
  /// The remaining [Card] objects in the deck.
  List<Card> cards;
  /// The card library in use with this deck.
  CardLibrary library;
  /// The [HeroCard] id for this deck.
  int heroCardId;

  /// Create a deck called [name] with the hero card [heroCardId] with given [cards].
  CardDeck(this.name, this.heroCardId, this.library, [this.cards]);

  /// Get the hero card from the library.
  HeroCard heroCard() => this.library.cardById(this.heroCardId);

  /// Returns whether the deck is out of cards
  bool isOutOfCards() => this.cards.length == 0;

  /// Take a card from the top of the [cards] list.
  Card drawCard() {
    if (this.isOutOfCards()) { return null; }

    return this.cards.removeAt(0);
  }
}