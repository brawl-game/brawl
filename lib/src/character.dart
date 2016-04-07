part of brawl;

/// A single character in a match
///
/// Characters are generally creatures existing on the board and can attack/defend
/// against other characters.
class Character extends GameEntity {
  /// The name of this character
  String name;
  /// How much damage the character deals when attacking
  int attack = 0;
  /// How much damage the character can take before dying
  int hitpoints = 0;
  /// The maximum hitpoints the character can have
  int hitpointsLimit = 0;

  /// Creates a Character called [name] with [attack] attack and [hitpoints] hitpoints
  /// that belongs to [game].
  Character(this.name, this.attack, this.hitpoints, Game game): super(game) {
    this.hitpointsLimit = this.hitpoints;
  }

  // MARK: Helpers

  /// Checks if the character is damaged
  bool isDamaged() {
    return (this.hitpoints < this.hitpointsLimit);
  }

  // MARK: Combat

  /// Calculates the real damage value
  int _realDamage(int damage, Character source) {
    if (damage <= 0) return 0;
    // TODO: Spell power, armor, etc.
    return damage;
  }

  /// Handles taking damage from an attacker
  bool handleDamage(int damage, Character source) {
    final realDamage = this._realDamage(damage, source);

    // TODO: Calculate armor mitigation
    this.hitpoints -= realDamage;

    return (realDamage > 0);
  }

  /// Tells this character to take some damage from a source
  void takeDamage(int damage, Character source) {
    if (damage <= 0) return;

    var inflicted = this.handleDamage(damage, source);
    if (!inflicted) return;

    final event = new GameEventDamageTaken(this, source, this._realDamage(damage, source));
    this.emit(event);
    this.game.emit(event);
  }

  /// Tells this character to deal some damage to a target
  void dealDamage(int damage, Character target) {
    target.takeDamage(damage, this);

    final event = new GameEventDamageDealt(target, this, target._realDamage(damage, this));
    this.emit(event);
    this.game.emit(new GameEventDeathCheck());
  }

  void attackCharacter(Character target) {
    this.dealDamage(this.attack, target);
    this.takeDamage(target.attack, target);
  }

  /// Destroys this character without combat events
  void destroy() {
    this.hitpoints = -1000;
    this.game.emit(new GameEventDeathCheck());
  }
}