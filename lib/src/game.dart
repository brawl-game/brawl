part of brawl;

/// A single game in the brawl engine
///
/// Contains functionality for distributing events, handling player actions and enforcing rulesets.
class Game extends Object with Events {
  /// The players competing in this Game instance.
  List<Player> players = [];

  /// The currently active player's index in the [players] array.
  int currentPlayerIndex = 0;

  /// History of the match.
  List<String> history = [];

  /// Add a string to the match [history].
  void log(String value) {
    this.history.add(value);
    print(value);
  }

  Game() {
    this.on(GameEvent, (e) => this.log(e.toString()));
  }

  /// Returns the currently active [Player] instance.
  Player currentPlayer() =>
    this.players[this.currentPlayerIndex];

  /// Returns the opponent for the currently active [Player].
  Player currentOpponent() =>
    this.players[this.nextPlayerIndex()];

  /// Returns the next-in-line player's index in the [players] array.
  int nextPlayerIndex() =>
    (this.currentPlayerIndex + 1) % (this.players.length);

  /// Returns whether or not the game can be started.
  bool isReady() =>
    this.players.length % 2 == 0;

  /// Prepares the game to begin.
  void initialize() {
    // TODO:
    // - Game.initialize() PRE_GAME_INIT hook and events.
    // - Initial game state
    // TODO: Randomize starting player
    this.currentPlayerIndex = 0;

    // Assign opponents
    this.currentPlayer().opponent = this.currentOpponent();
    this.currentOpponent().opponent = this.currentPlayer();

    // Draw starting hands
    this._drawStartingCards();

    // TODO: Game.initialize() POST_GAME_INIT hook and events.
  }

  void start() {
    this.currentPlayer().mana = 1;
    this.currentPlayer().manaSlots = 1;

    this.players.forEach((player) {
      while (player.hand.length < 4) {
        player.drawCard();
      }
    });

    this.startTurn();
  }

  void startTurn() {
    // Get current player
    var currentPlayer = this.currentPlayer();

    // Emit start of turn events
    var event = new GameEventTurnStart(currentPlayer);
    currentPlayer.emit(event);
    this.emit(event);
  }

  void endTurn() {
    // Send the GameEventTurnEnd events
    final player = this.currentPlayer();
    final event  = new GameEventTurnEnd(player);
    player.emit(event);
    this.emit(event);

    // Switch to next player and start their turn
    this.currentPlayerIndex = this.nextPlayerIndex();
    this.startTurn();
  }

  // MARK: Private

  void _drawStartingCards() {
    this.players.forEach((player) {
      while (player.hand.length < 3) {
        player.drawCard();
      }
    });
    this.currentOpponent().drawCard();
  }
}