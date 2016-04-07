library brawl.card;
import 'dart:convert';

/// The base class for all types of cards
class Card {
  /// The name of this card.
  String name;
  /// The cost in mana to play this card.
  int cost = 0;
  /// The [CardSet] this Card belongs to.
  CardSet cardSet;
  /// Whether this card is a token (doesn't go into decks)
  bool isToken = false;

  /// Create a new [Card] called [name] that costs [cost] mana.
  Card(this.name, this.cost);

  /// Map a JSON [Map] into a [Card]
  Card.fromJSON(Map jsonMap) {
    this.name = jsonMap["name"];
    this.cost = jsonMap["cost"];
    this.isToken = jsonMap["is_token"];
  }
}

/// A Card that summons a Creature on the board.
class CreatureCard extends Card {
  /// The attack power of this Creature
  int attack;
  /// The health value of this Creature
  int health;

  /// Create a new [CreatureCard] called [name] with [attack] attack
  /// and [health] health that costs [cost] mana
  CreatureCard(String name, int cost, this.attack, this.health):
    super(name, cost);

  /// Map [jsonMap] into a [CreatureCard]
  CreatureCard.fromJSON(Map jsonMap): super.fromJSON(jsonMap) {
    this.attack = jsonMap["attack"];
    this.health = jsonMap["health"];
  }
}

/// A Card that triggers an action when played.
class SpellCard extends Card {
  /// Create a new SpellCard called [name] that costs [cost] mana.
  SpellCard(String name, int cost): super(name, cost);

  /// Map [jsonMap] into a [SpellCard]
  SpellCard.fromJSON(Map jsonMap): super.fromJSON(jsonMap);
}

/// A Card that represents the player's chosen hero
class HeroCard extends Card {
  /// Name of the [AbilityCard] for this Hero.
  String abilityCardName;

  /// Create a new HeroCard called [name].
  HeroCard(String name, String abilityCardName): super(name, 0) {
    this.abilityCardName = abilityCardName;
  }

  /// Map [jsonMap] into a [HeroCard]
  HeroCard.fromJSON(Map jsonMap): super.fromJSON(jsonMap) {
    this.abilityCardName = jsonMap["ability_card_name"];
  }

  /// Returns the [Card] for this HeroCard's ability.
  Card abilityCard() => this.cardSet.cardByName(this.abilityCardName);
}

/// A Unique collection of certain cards, e.g. "Goblins vs. Gnomes" expansion.
class CardSet {
  /// The name of the set
  String name;

  /// Name->Map mapping of all the cards in this set.
  Map<String, Card> cards;

  /// Create a new set of cards called [name] with optional [cards].
  CardSet(this.name, [this.cards]) {
    this.cards = {};
  }

  /// Add a new [card] to this set
  Card addCard(Card card) {
    card.cardSet = this;
    return this.cards.putIfAbsent(card.name, () => card);
  }

  /// Returns whether a card with [card]'s name exists in this set already.
  bool containsCard(Card card) =>
    this.cards[card.name] != null;

  /// Returns a [Card] by [name]
  Card cardByName(String name) =>
    this.cards[name];
}