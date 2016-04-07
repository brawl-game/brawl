part of brawl;

/// A Card that represents the player's chosen hero
class HeroCard extends Card {
  /// Name of the [AbilityCard] for this Hero.
  int abilityCardId;

  /// Create a new HeroCard called [name].
  HeroCard(int id, String name, int abilityCardId): super(id, name, 0) {
    this.abilityCardId = abilityCardId;
  }

  /// Map [jsonMap] into a [HeroCard]
  HeroCard.fromJSON(Map jsonMap): super.fromJSON(jsonMap) {
    this.type = CardType.HERO;
    this.abilityCardId = jsonMap["ability_card_id"];
  }

  /// Returns the [Card] for this HeroCard's ability.
  Card abilityCard() => this.library.cardById(this.abilityCardId);
}