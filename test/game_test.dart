library brawl.test;

import 'dart:convert';
import 'package:brawl/brawl.dart';
import 'package:guinness/guinness.dart';
import 'package:faker/faker.dart';

// Utilities
final faker = new Faker();
final json  = new JsonDecoder();

// Objects
var library;

void main() {
  describe('Game', () {
    var game = new Game();
    var cardLibrary;
    var playerOne, playerTwo;
    var deckOne, deckTwo;

    beforeEach(() async {
      // Create game
      game = new Game();

      // Load library
      var resource = new Resource("package:brawl/res/basic.json");
      await resource.readAsString().then((data) {
        cardLibrary = new CardLibrary.fromJSONMap(json.convert(data));
      });

      // Create decks
      deckOne = new CardDeck("Test 1", cardLibrary.randomCardOfType(CardType.HERO).id, cardLibrary, []);
      deckTwo = new CardDeck("Test 2", cardLibrary.randomCardOfType(CardType.HERO).id, cardLibrary, []);

      // Create players
      playerOne = new Player(faker.person.name(), deckOne);
      playerTwo = new Player(faker.person.name(), deckTwo);

      // Join the game
      playerOne.joinGame(game);
      playerTwo.joinGame(game);
    });

    describe('Players', () {
      it('should accept new players', () {
        expect(game.players.length).toEqual(2);
      });

      it('cannot be started without %2 players', () {
        expect(game.isReady()).toEqual(true);
        game.players.removeLast();
        expect(game.isReady()).toEqual(false);
      });

      it('should change active player index', () {
        game.initialize();
        game.start();
        expect(game.currentPlayerIndex).toEqual(0);
        game.endTurn();
        expect(game.currentPlayerIndex).toEqual(1);
        game.endTurn();
        expect(game.currentPlayerIndex).toEqual(0);
        game.endTurn();
      });
    });
  });
}
