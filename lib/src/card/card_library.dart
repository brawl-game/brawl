part of brawl;

/// A Unique collection of certain cards, e.g. "Goblins vs. Gnomes" expansion.
class CardLibrary {
  /// The name of the set
  String name;

  /// Name->Map mapping of all the cards in this set.
  Map<String, Card> cards = {};

  /// Create a new set of cards called [name] with optional [cards].
  CardLibrary(this.name, [this.cards]);

  /// Create a library from a pre-defined library JSON
  CardLibrary.fromJSONMap(Map jsonMap) {
    this.name = jsonMap["name"];
    for (var cardMap in jsonMap["cards"]) {
      this.addCard(Card.cardFromJSONMap(cardMap));
    }
  }

  /// Add a new [card] to this set
  Card addCard(Card card) {
    card.library = this;
    return this.cards.putIfAbsent(card.name, () => card);
  }

  /// Returns whether a card with [card]'s name exists in this set already.
  bool containsCard(Card card) => this.cards[card.name] != null;

  /// Returns a [Card] by [name]
  Card cardByName(String name) => this.cards[name];

  /// Returns a [Card] by [id]
  Card cardById(int id) {
    for (var card in this.cards.values) {
      if (card.id == id) { return card; }
    }
    return null;
  }

  /// Returns all the [Card] objects of a given [type] in the library.
  List<Card> cardsOfType(CardType type) {
    return this.cards.values.where((card) {
      return card.type == type;
    });
  }

  /// Returns a random [Card] of a given [type].
  Card randomCardOfType(CardType type) {
    var cards = this.cards.values.where((card) {
      return card.type == type;
    }).toList(growable: false);

    cards.shuffle();

    return cards.first;
  }
}