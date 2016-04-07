part of brawl;

/// A Card that triggers an action when played.
class SpellCard extends Card {
  /// Create a new SpellCard called [name] that costs [cost] mana.
  SpellCard(int id, String name, int cost): super(id, name, cost);

  /// Map [jsonMap] into a [SpellCard]
  SpellCard.fromJSON(Map jsonMap): super.fromJSON(jsonMap) {
    this.type = CardType.SPELL;
  }
}