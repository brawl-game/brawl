part of brawl;

/// The base class for all types of cards
class Card {
  /// The unique id of this card.
  int id = 0;
  /// The name of this card.
  String name;
  /// The cost in mana to play this card.
  int cost = 0;
  /// The [CardLibrary] this Card belongs to.
  CardLibrary library;
  /// Whether this card is a token (doesn't go into decks)
  bool isToken = false;
  /// The [CardType] of this Card.
  CardType type;

  /// Create a new [Card] with the ID [id] called [name] that costs [cost] mana.
  Card(this.id, this.name, this.cost);

  /// Map a JSON [Map] into a [Card]
  Card.fromJSON(Map jsonMap) {
    this.id = jsonMap["id"];
    this.name = jsonMap["name"];
    this.cost = jsonMap["cost"];
    this.isToken = jsonMap["is_token"];
  }

  /// Attempt to get the proper [Card] subclass from the json map.
  static dynamic cardFromJSONMap(Map jsonMap) {
    CardType type = cardTypeFromString(jsonMap["type"]);
    switch (type) {
      case CardType.HERO:
        return new HeroCard.fromJSON(jsonMap);
      case CardType.CREATURE:
        return new CreatureCard.fromJSON(jsonMap);
      default:
        return new SpellCard.fromJSON(jsonMap);
    }
  }
}