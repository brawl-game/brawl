part of brawl;

/// A Card that summons a Creature on the board.
class CreatureCard extends Card {
  /// The attack power of this Creature
  int attack;
  /// The health value of this Creature
  int health;

  /// Create a new [CreatureCard] called [name] with [attack] attack
  /// and [health] health that costs [cost] mana
  CreatureCard(int id, String name, int cost, this.attack, this.health):
    super(id, name, cost);

  /// Map [jsonMap] into a [CreatureCard]
  CreatureCard.fromJSON(Map jsonMap): super.fromJSON(jsonMap) {
    this.type   = CardType.CREATURE;
    this.attack = jsonMap["attack"];
    this.health = jsonMap["health"];
  }
}