part of brawl;

/// Generic [Player] owned game entity that belongs to a [Game].
class GameEntity extends Object with Events {
  /// Original owner of the Entity
  Player owner;
  /// Current controlling player of the Entity
  Player controller;
  /// The Game that this entity belongs to
  Game game;

  /// Creates a new GameEntity that belongs to [game].
  GameEntity(this.game);

  /// Gets the current controller of the GameEntity
  Player getController() {
    return (this.controller == null) ? this.owner : this.controller;
  }
}