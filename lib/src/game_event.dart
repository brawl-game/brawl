part of brawl;

/// MARK: Game Events

/// A base class for all [GameEvent] subclasses.
class GameEvent extends Object with Events { }

/// Sent after characters are destroyed, damaged and after combat
class GameEventDeathCheck extends GameEvent { }

/// MARK: Player Events

/// Sent when a [Player]'s turn has started.
class GameEventTurnStart extends GameEvent {
  Player player;

  GameEventTurnStart(this.player);

  String toString() => "${this.player.name}'s turn starts.";
}

/// Sent when a [Player]'s turn has ended.
class GameEventTurnEnd extends GameEvent {
  Player player;

  GameEventTurnEnd(this.player);

  String toString() => "${this.player.name}'s turn ends.";
}

/// Sent when a [Player] draws a [Card];
class GameEventDrawCard extends GameEvent {
  Player player;
  Card card;

  GameEventDrawCard(this.player, this.card);

  String toString() => "${this.player.name} drew card: ${this.card.name}.";
}

/// Sent when a [Player] joins a [Game];
class GameEventJoinGame extends GameEvent {
  Player player;

  GameEventJoinGame(this.player);

  String toString() => "${this.player.name} joined the game.";
}

/// MARK: Combat Events

/// Generic two-way damage event between two characters
class GameEventDamage extends GameEvent {
  Character target;
  Character source;
  int amount;

  GameEventDamage(this.target, this.source, this.amount);

  String toString() => "${this.source.name} deals ${this.amount} damage to ${this.target.name}.";
}

/// Sent after the [source] deals [amount] damage to [target]
class GameEventDamageDealt extends GameEventDamage {
  GameEventDamageDealt(Character target, Character source, int amount): super(target, source, amount);
}

/// Sent after the [target] takes [amount] damage from [source]
class GameEventDamageTaken extends GameEventDamage {
  GameEventDamageTaken(Character target, Character source, int amount): super(target, source, amount);
}

// MARK: Playing cards

class GameEventPlayCard extends GameEvent {
  Player player;
  Card card;

  GameEventPlayCard(this.player, this.card);

  String toString() => "${this.player.name} plays ${this.card.name}.";
}

class GameEventSummonCreature extends GameEvent {
  Player player;
  Creature creature;
  int index;

  GameEventSummonCreature(this.player, this.creature, this.index);

  String toString() => "${this.player.name} summons ${this.creature.name}.";
}

class GameEventCastSpell extends GameEvent {
  Player player;
  SpellCard spell;
  Character target;

  GameEventCastSpell(this.player, this.spell, this.target);

  String toString() => "${this.player.name} casts ${this.spell.name} on ${this.target.name}.";
}