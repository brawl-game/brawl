part of brawl;

class Creature extends Character {
  /// The Card this creature was created from.
  CreatureCard card;

  /// Create a Creature called [name] with [attack] attack and [hitpoints] hitpoints
  /// that belongs to [owner].
  Creature(String name, int attack, int hitpoints, Player owner): super(name, attack, hitpoints, owner.game) {
    this.controller = this.owner = owner;
  }

  /// Create a Creature from a given [CreatureCard].
  Creature.fromCard(CreatureCard card, Player owner): super(card.name, card.attack, card.health, owner.game) {
    this.controller = this.owner = owner;
    this.card = card;
  }
}